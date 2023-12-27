Return-Path: <linux-kernel+bounces-11942-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EDE381EDFA
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 11:02:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 91A131C21792
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 10:02:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA15A2C872;
	Wed, 27 Dec 2023 10:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="Kg72yz2U"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A7CBEAEF;
	Wed, 27 Dec 2023 10:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1703671351; x=1704276151; i=markus.elfring@web.de;
	bh=BM+3GCkN62Jm+ibbTYmurrrehvX2xjyaS6ajGuDTOCk=;
	h=X-UI-Sender-Class:Date:To:Cc:From:Subject;
	b=Kg72yz2UbAQyXRw33tKr4nyVDFhSIy9rh8TX3eV143f9GNTsY/yMWalt44bU9vQg
	 c2IarJnrVEmkjFAodF6Upe5Xdykv4QD0gy/KL7nbG/3smCEYwVH9ToofXxCLsGRRR
	 GuV2zq6zKQvhs49hhjmSt0NQ2I04A07LPtaFUDXhxhZ1Y0CsA4cqxP3bpwrQRBKYv
	 /VqBviQo7aLXJgAMMcLc8CafwS5nTPPXRoEk2TIOYNHaLtOpVK2rAyozZ7M9Mb5At
	 3Qwbcwk7uZ3FuqzaTrR8flGaERtf/MFKoaHHAl6T8/ShsCkgz6kDqD6YyfPzbhUHL
	 TrML8nmaYuYdsvHs9A==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.95]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MQgks-1ret2P19wk-00O5AO; Wed, 27
 Dec 2023 11:02:31 +0100
Message-ID: <c8b0d40c-2f48-46fa-8311-258985e9eee3@web.de>
Date: Wed, 27 Dec 2023 11:02:13 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: linux-scsi@vger.kernel.org, MPT-FusionLinux.pdl@broadcom.com,
 kernel-janitors@vger.kernel.org, Sathya Prakash
 <sathya.prakash@broadcom.com>, Sreekanth Reddy
 <sreekanth.reddy@broadcom.com>,
 Suganath Prabu Subramani <suganath-prabu.subramani@broadcom.com>
Content-Language: en-GB
Cc: LKML <linux-kernel@vger.kernel.org>, cocci@inria.fr
From: Markus Elfring <Markus.Elfring@web.de>
Subject: [PATCH 0/2] scsi: message: fusion: Adjustments for
 mptsas_find_phyinfo_by_phys_disk_num()
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:m0i11EupOqIN+RxAkfJ6j/nOGRmmUMJ3UthFLNpq+mmlXNSm6Xw
 C3Z5xj17GW5p3r298rQb5s+1UMLPB85l6o7YKiLd/7jCgIxtTmsChw0eKnhEPsuB1a9coN6
 RpP8SJP7ydsY5Geca6Sct7GK78fs+H47aFzlXmnk1Q4pgHLb6FQtE7YrvE23/D2T6ePUG7A
 hTbFGT2ZFsdcVQ0T6jNhg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:WAO27yQdnLI=;Ek3jJEzNzGipfemHRUBCD1jkl29
 OkdqveBICjeHH+HZ3g3F7m2kCv+dnlls1Bz3MMEtP3wjRkc2yeYi2NIW4Os0l634E5Z2Iq07U
 zDMPVnYe2b0bI9bVxRH8vANJgJoF+aeyTu+baUxSKqiaU/xtubb64nchHMXs9g+/11ayvstso
 wtQJuSSXt65h1NoR7Sr2UAFpW2+p3OKYZqHZUwjyZTDyDFyyWWeEZp9amv+FbyVF8EGJfS6kU
 O75FlTf7Dmwd5myZtUNLe531COURnnVtwMbeB79CUX4PaxuopPkY90INsqf6ZnXMQKLCxSS3z
 BXDcfoxWO1tjdwgb/aaKICaYitSOAwS2x8JlruMOfOmYTpltTwBuOhaFdvnS0NxtdjVAAn2DH
 agm7A4t0RJ+SfqsPFZpVf48/r2eZModKvCJFgoVzB7SCxXWjvzs48GGfbMEHVuTqL3aKbOZbx
 S/SC1fET4B0/wbdTEWTrbWF/VsinMoiwRIvQe6MW+iv2FeuKWQZ3sHcMz/bGH82FEXANC+aQf
 XKmwCWj1mNpQHv3zQbv4295i/0ypIDVII2TOYRwO7El4UoqLP5HnHB45FN7IzxugNYlwMpP5S
 4mRoBAOcz4stzOVByspF953XYmjCoKZ4x7mzAXY3hwFMqcHC7C+6KUcOyamEe3qP/3VTKKLgL
 z5GoZvvgCR1eeKzGjBXztHLNMK40Awr1vClzzEkdHuFJhrD1G5bxGPWHqxjVR+uaaI5w7Yy/5
 gnmnndosF1AwXnathQae42G4b607XnV0N1AxFEhYe1QMHbEwraaffEyjlLVZ4sufnhSVjEdAF
 6MGgpW0Uf+kRBZSSqNp+kIdqY8C7d4n8pJauW51D+2wu4Op6uwSt63Ggk78QuwrBEoP7yTWjD
 dPE7K6GLyNtekHB/E3BIdhNXCtdRarJRAHazpqM9LuyM/GnLsbLnJ1xqeauTwQumyN69jLxun
 7TDP9w==

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Wed, 27 Dec 2023 10:54:32 +0100

A few update suggestions were taken into account
from static source code analysis.

Markus Elfring (2):
  Improve data processing
  Move an assignment for the variable =E2=80=9Cphy_info=E2=80=9D

 drivers/message/fusion/mptsas.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

=2D-
2.43.0


