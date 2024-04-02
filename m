Return-Path: <linux-kernel+bounces-128080-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DC7B8955CB
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 15:52:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 284B61F23165
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 13:52:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7260284A2C;
	Tue,  2 Apr 2024 13:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="D8UnmUe+"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 256FB634E5
	for <linux-kernel@vger.kernel.org>; Tue,  2 Apr 2024 13:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712065921; cv=none; b=oD0k8SXpNilGWv7pll7qXk+HeqW37DbOktCcwic22hFvxF22v+qrMCW9lUo83D5sGOLydqZpGdJZAVMjaWdQKtJwiIBPAM/UdKpqNvuOzMqjIfQ47lGv2SDRl4+vWgn+aTSBly+Y/HjlsycKMjyDUHGvDZDj5J+ZE2GszuP2gHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712065921; c=relaxed/simple;
	bh=B4ma/e/KnR+uU5X9v8DluYFVCl1ZEucVYQW3EfXqAJ4=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Cc:Content-Type; b=INqogvIkR1I9IMb3M3teAayMLdUhQgYy85z9IEqZxuKC9JZivx0vhjKTZoC7bMJR2YlMJkffr7+wDjAiI/9B3/VSi2E3Jh00I5gN2IrZs/7oIZ0xme0kispTmdR1wBAxcqkFmExjoroEDrnfKmHWcfdvLWusRwDApiNZ95aVS5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.vnet.ibm.com; spf=none smtp.mailfrom=linux.vnet.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=D8UnmUe+; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.vnet.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 432DgJAM021352;
	Tue, 2 Apr 2024 13:51:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : to : from : subject : cc : content-type :
 content-transfer-encoding; s=pp1;
 bh=ZyUFALjx6viMMzdOywgL4/zB9g6cPayR5XSV8h2scQg=;
 b=D8UnmUe+TQp/rNg8uykrQb9D/aRlBxqXYhW0bfx7udPsSNippnBtG+eBImKhGwKRdluw
 yKqdNwUob3qh9s0LhaTK89Ki6Gk6Fuv37QjhSGJTRVMP8O94VNpxTVx8qBD+uxOTGPY2
 Tf+6XKCjEqj3fRVAbYiYIPF6r6yGuBhNCxDRe9u5FYOV70wM0NbeUFsSutWPoOIXLQ8I
 ygo+OMMX9k8Amf1XM+ywDDGzJkCzTeJAD7rJiQ2zBFDc9HmqxuQj4fL1AwCy5OS9kp9z
 bARPFZ/irp6ADBoaP+vcwePujQey+Eg9OdP1ma/flxncQDdGJY01zTlu7T5zBm+Tcr/a +w== 
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3x8k0mg131-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 02 Apr 2024 13:51:40 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 432Cuoeo008419;
	Tue, 2 Apr 2024 13:51:38 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3x6w2ty2hf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 02 Apr 2024 13:51:38 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 432DpZRC16909050
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 2 Apr 2024 13:51:37 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 523D85806D;
	Tue,  2 Apr 2024 13:51:35 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C0A465805E;
	Tue,  2 Apr 2024 13:51:31 +0000 (GMT)
Received: from [9.43.62.54] (unknown [9.43.62.54])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  2 Apr 2024 13:51:31 +0000 (GMT)
Message-ID: <62efbf21-fdb5-4c3b-a370-085b39672b72@linux.vnet.ibm.com>
Date: Tue, 2 Apr 2024 19:21:30 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-GB
To: Alexander@wetzel-home.de, bvanassche@acm.org, martin.petersen@oracle.com,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
From: Venkat Rao Bagalkote <venkat88@linux.vnet.ibm.com>
Subject: [Revert commit 27f58c04a8f438078583041468ec60597841284d] [linux-next]
 [6.9.0-rc1-next-20240328] WARNING: CPU: 9 PID: 209 at drivers/scsi/sg.c:2236
 sg_remove_sfp_usercontext+0x270/0x280 [sg]
Cc: sfr@canb.auug.org.au, sachinp@linux.vnet.com, mpe@ellerman.id.au,
        abdhalee@linux.vnet.ibm.com, mputtash@linux.vnet.com
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: pZ5TDoYdJf9sBdDIlbdMDid7UGTHjEdC
X-Proofpoint-ORIG-GUID: pZ5TDoYdJf9sBdDIlbdMDid7UGTHjEdC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-02_06,2024-04-01_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 spamscore=0
 impostorscore=0 mlxscore=0 lowpriorityscore=0 bulkscore=0 adultscore=0
 mlxlogscore=999 suspectscore=0 priorityscore=1501 clxscore=1011
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2403210000 definitions=main-2404020101

Greetings!!


Below warnings is observed with the commit 
27f58c04a8f438078583041468ec60597841284d.


Once reverting the above commit id, issue is resloved.


Please help in fixing this issue.


   470.425710] ------------[ cut here ]------------
[  470.425728] WARNING: CPU: 5 PID: 226 at drivers/scsi/sg.c:2236 sg_remove_sfp_usercontext+0x270/0x280 [sg]
[  470.425739] Modules linked in: nvram nft_compat nf_tables libcrc32c nfnetlink rpadlpar_io rpaphp xsk_diag bonding tls rfkill binfmt_misc vmx_crypto pseries_rng dax_pmem drm drm_panel_orientation_quirks ext4 mbcache jbd2 dm_service_time sd_mod t10_pi crc64_rocksoft_generic crc64_rocksoft crc64 sg nd_pmem nd_btt ibmvfc papr_scm ibmvnic scsi_transport_fc ibmveth libnvdimm dm_multipath dm_mirror dm_region_hash dm_log dm_mod fuse
[  470.425778] CPU: 5 PID: 226 Comm: kworker/5:1 Kdump: loaded Not tainted 6.9.0-rc1-next-20240328-auto #1
[  470.425784] Hardware name: IBM,9080-HEX POWER10 (raw) 0x800200 0xf000006 of:IBM,FW1060.00 (NH1060_016) hv:phyp pSeries
[  470.425788] Workqueue: events sg_remove_sfp_usercontext [sg]
[  470.425794] NIP:  c008000004904110 LR: c008000004903ffc CTR: c0000000005391a0
[  470.425799] REGS: c000000092297ae0 TRAP: 0700   Not tainted  (6.9.0-rc1-next-20240328-auto)
[  470.425803] MSR:  800000000282b033 <SF,VEC,VSX,EE,FP,ME,IR,DR,RI,LE>  CR: 44000204  XER: 00000001
[  470.425814] CFAR: c00800000490400c IRQMASK: 0
[  470.425814] GPR00: c008000004903ffc c000000092297d80 c008000004928900 c000000090581298
[  470.425814] GPR04: 00000000c0000000 0000000000001281 c0000000056e0000 0000000000001280
[  470.425814] GPR08: 000000135acf0000 0000000000000002 0000000000000000 c008000004908bc0
[  470.425814] GPR12: c0000000005391a0 c0000013ffff9300 c0000000001a2b5c c0000000995efac0
[  470.425814] GPR16: 0000000000000000 0000000000000000 0000000000000000 0000000000000000
[  470.425814] GPR20: c00000135cfb3b00 c0000000056fc030 c0000000056fc000 c0000000b15d3000
[  470.425814] GPR24: 0000000000000000 c000000090581200 c0000000044e6c05 c0000000056fd330
[  470.425814] GPR28: c00000135cfb3b00 c0000000056fc080 c0000000056fd328 c000000002fdee44
[  470.425858] NIP [c008000004904110] sg_remove_sfp_usercontext+0x270/0x280 [sg]
[  470.425864] LR [c008000004903ffc] sg_remove_sfp_usercontext+0x15c/0x280 [sg]
[  470.425870] Call Trace:
[  470.425872] [c000000092297d80] [c008000004903ffc] sg_remove_sfp_usercontext+0x15c/0x280 [sg] (unreliable)
[  470.425879] [c000000092297e40] [c00000000019332c] process_one_work+0x20c/0x4f4
[  470.425887] [c000000092297ef0] [c0000000001942ac] worker_thread+0x378/0x544
[  470.425892] [c000000092297f90] [c0000000001a2c8c] kthread+0x138/0x140
[  470.425898] [c000000092297fe0] [c00000000000df98] start_kernel_thread+0x14/0x18
[  470.425903] Code: e8c98310 3d220000 e8698010 480044bd e8410018 7ec3b378 48004ac9 e8410018 38790098 81390098 2c090001 4182ff04 <0fe00000> 4bfffefc 000247e0 00000000
[  470.425917] ---[ end trace 0000000000000000 ]---

Regards,
Venkat.


