Return-Path: <linux-kernel+bounces-54182-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90C2B84AC02
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 03:09:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B59671C23550
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 02:09:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 380335732C;
	Tue,  6 Feb 2024 02:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="b+KMj6tv"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78EBA56B6F;
	Tue,  6 Feb 2024 02:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707185358; cv=none; b=E7PEzjVEZxWqzIHGlJ7z4Na+iQX7i8W99HKf7Su6+Mi6X7v0F3QzWHRZl3DFV8/M82VMIQter1OaQqFNxhyRkwI9MVVmFFoMHvJll2QaRqWktz79YKJv368I7gGhrVHY06aRlpznxQK3BF7Q+jgP9oKaEhJidVe4r9/hXO1i8Ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707185358; c=relaxed/simple;
	bh=WYfoRPya76Tqck0ScDgB0y5w0roJ0OYNP1LTT+2qcEk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JeHGi5PkP5aBV4JD0Kmh/1Gmst9kmQ2fRsukbqwjuNpgEyp7RogdrwtIfOvTuRdrwHH175kx2jFIXfCvTML7bcW/xYA6k+K17lVx6pZ+DK/N07YfD5MCMpAVyafzxXHUPk465qrTImGkkJgSIoeIM9leUAJv3wGldj3E1pUyh3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=b+KMj6tv; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 4161EYUn020918;
	Tue, 6 Feb 2024 02:08:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2023-11-20;
 bh=TNBqmrMN0GKiz0meyol2MTt7jK7ZOMX41ADnOQ7L/UU=;
 b=b+KMj6tvO4efzEbKZhSG/xzlHnsPmbgMlBfcTWawkZTnAIffaQla4J5cVDofspUuJqWS
 /o00HHnk0n3gN9qp3mx/3E4gJC1I52m2sdoqn6JFMG+i8UwxEXr0NcQnIWxdhEFBJn+E
 /x8af1pQLtk1k1AM1L7u822p8aQ15VNJPSq8MPE9D4515Gx5HixPyTgAvA3/EgoqxoHI
 QgW4sF8UUf5WKq6QgWwluTQ92vNZ9x/szjLyibVmDwZBAu8ox17jHGO02Dm+ih1uUcH6
 DGK4SsClE47m3SK3AzW4xYXw6GyPWvrQpLAswBi0lOq+tWmzWKU14KToHTtMKtqix0Tu 5w== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3w1bwengt7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 06 Feb 2024 02:08:03 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 4160ucci039478;
	Tue, 6 Feb 2024 02:08:02 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3w1bx6cdtw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 06 Feb 2024 02:08:02 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 41627qHJ034652;
	Tue, 6 Feb 2024 02:08:01 GMT
Received: from ca-mkp2.ca.oracle.com.com (mpeterse-ol9.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.251.135])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3w1bx6cdrb-2;
	Tue, 06 Feb 2024 02:08:01 +0000
From: "Martin K. Petersen" <martin.petersen@oracle.com>
To: linux-kernel@vger.kernel.org, Li Zhijian <lizhijian@fujitsu.com>
Cc: "Martin K . Petersen" <martin.petersen@oracle.com>,
        Adaptec OEM Raid Solutions <aacraid@microsemi.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Alistar Popple <alistair@popple.id.au>,
        "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Artur Paszkiewicz <artur.paszkiewicz@intel.com>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        =?UTF-8?q?Bruno=20Pr=C3=A9mont?= <bonbons@linux-vserver.org>,
        Chandrakanth patil <chandrakanth.patil@broadcom.com>,
        Christian Gromm <christian.gromm@microchip.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>, cocci@inria.fr,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Don Brace <don.brace@microchip.com>, dri-devel@lists.freedesktop.org,
        Eddie James <eajames@linux.ibm.com>,
        GR-QLogic-Storage-Upstream@marvell.com,
        Hannes Reinecke <hare@kernel.org>, Hannes Reinecke <hare@suse.de>,
        Hans de Goede <hdegoede@redhat.com>, Helge Deller <deller@gmx.de>,
        HighPoint Linux Team <linux@highpoint-tech.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ian Rogers <irogers@google.com>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>, Jack Wang <jinpu.wang@cloud.ionos.com>,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        James Morse <james.morse@arm.com>, Jeremy Kerr <jk@ozlabs.org>,
        Jiri Kosina <jikos@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
        Joel Stanley <joel@jms.id.au>, Jonathan Cameron <jic23@kernel.org>,
        Julia Lawall <Julia.Lawall@inria.fr>,
        Karan Tilak Kumar <kartilak@cisco.com>,
        Kashyap Desai <kashyap.desai@broadcom.com>,
        Ketan Mukadam <ketan.mukadam@broadcom.com>,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>,
        linux-arm-kernel@lists.infradead.org, linux-edac@vger.kernel.org,
        linux-fbdev@vger.kernel.org, linux-fsi@lists.ozlabs.org,
        linux-iio@vger.kernel.org, linux-input@vger.kernel.org,
        linux-perf-users@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-scsi@vger.kernel.org, Manish Rangankar <mrangankar@marvell.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        megaraidlinux.pdl@broadcom.com, Michael Cyr <mikecyr@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Michal Januszewski <spock@gentoo.org>,
        MPT-FusionLinux.pdl@broadcom.com, Namhyung Kim <namhyung@kernel.org>,
        "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>, netdev@vger.kernel.org,
        Nicholas Piggin <npiggin@gmail.com>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Nilesh Javali <njavali@marvell.com>,
        Parthiban Veerasooran <parthiban.veerasooran@microchip.com>,
        Peter Zijlstra <peterz@infradead.org>,
        platform-driver-x86@vger.kernel.org,
        Richard Cochran <richardcochran@gmail.com>,
        Robert Richter <rric@kernel.org>, Russell King <linux@armlinux.org.uk>,
        Sathya Prakash <sathya.prakash@broadcom.com>,
        Satish Kharat <satishkh@cisco.com>,
        Sesidhar Baddela <sebaddel@cisco.com>,
        Shivasharan S <shivasharan.srikanteshwara@broadcom.com>,
        Sreekanth Reddy <sreekanth.reddy@broadcom.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Stefan Achatz <erazor_de@users.sourceforge.net>,
        storagedev@microchip.com, Stuart Yoder <stuyoder@gmail.com>,
        Suganath Prabu Subramani <suganath-prabu.subramani@broadcom.com>,
        Sumit Saxena <sumit.saxena@broadcom.com>, target-devel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>, Tony Luck <tony.luck@intel.com>,
        Tyrel Datwyler <tyreld@linux.ibm.com>,
        Vadim Pasternak <vadimp@nvidia.com>, x86@kernel.org
Subject: Re: (subset) [PATCH 00/42] Fix coccicheck warnings
Date: Mon,  5 Feb 2024 21:07:38 -0500
Message-ID: <170715263710.945763.16540743989774199712.b4-ty@oracle.com>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20240116041129.3937800-1-lizhijian@fujitsu.com>
References: <20240116041129.3937800-1-lizhijian@fujitsu.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-05_18,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 phishscore=0
 spamscore=0 adultscore=0 mlxlogscore=999 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2402060013
X-Proofpoint-ORIG-GUID: pTT_U64MvKVXcaNppMcpJ2F1AhkrIKYI
X-Proofpoint-GUID: pTT_U64MvKVXcaNppMcpJ2F1AhkrIKYI

On Tue, 16 Jan 2024 12:10:47 +0800, Li Zhijian wrote:

> make coccicheck COCCI=$PWD/scripts/coccinelle/api/device_attr_show.cocci`
> complians some warnnings as following[1]:
> 
> Not sure if someone had tried these fixes, feel free to ignore this
> patch set if we have come to a *NOT-FIX* conclusion before :)
> 
> This patch set also fix a few snprintf() beside coccicheck reported.
> For example, some thing like
> xxx_show() {
> 	rc = snprintf();
> ...
> 	return rc;
> }
> 
> [...]

Applied to 6.9/scsi-queue, thanks!

[22/42] drivers/scsi/fnic: Convert snprintf to sysfs_emit
        https://git.kernel.org/mkp/scsi/c/1ad717c92925
[25/42] drivers/scsi/ibmvscsi: Convert snprintf to sysfs_emit
        https://git.kernel.org/mkp/scsi/c/29ff822f466e
[26/42] drivers/scsi/ibmvscsi_tgt: Convert snprintf to sysfs_emit
        https://git.kernel.org/mkp/scsi/c/01105c23de42
[27/42] drivers/scsi/isci: Convert snprintf to sysfs_emit
        https://git.kernel.org/mkp/scsi/c/5fbf37e53091
[34/42] drivers/scsi/pm8001: Convert snprintf to sysfs_emit
        https://git.kernel.org/mkp/scsi/c/8179041f801d

-- 
Martin K. Petersen	Oracle Linux Engineering

