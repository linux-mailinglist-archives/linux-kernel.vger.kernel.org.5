Return-Path: <linux-kernel+bounces-139277-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B6238A00DE
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 21:49:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B80831F22907
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 19:49:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2585181B87;
	Wed, 10 Apr 2024 19:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="SSCtRnD/"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82465181CF2;
	Wed, 10 Apr 2024 19:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712778547; cv=none; b=iAXdn69fgIVwDOYnfLBWt914EtXjecsHsrO8lbEb1HBOlcqICvJIVrtL+XzPff2XEhddUiwvY1Lm+CMXP+vkCAf6G6zRhQR3PHUrbt0/jP6PpU1ApXbMRgUwMhkngndPZmyeZ560ZvHYoaGy6f/sW+Gn9WBaU5w9lNBOV0RVaaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712778547; c=relaxed/simple;
	bh=63JP6mRsPQF+sdjTdy07y7KOtlByYMY51Dn2cnAOUqs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dLatP5fhjVEwdeZppb285VGA5JoQZgdm0k5RM7Jbb2zDZhVDbsjrNIeogGbjU6exULWvPou3w2d1qTPgZUBUi2C+68T8b3bjR1bjCQaE6aRL+jC1EGfEhph9tJ5sJCYcGJv04vgJfowR+8hZGwEepBH2L5mOP3iWuT0kSC6lk1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=SSCtRnD/; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43AJbXRG024982;
	Wed, 10 Apr 2024 19:48:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : reply-to : to : cc : date : in-reply-to : references : content-type
 : mime-version; s=pp1; bh=DO4vQFzy+fNYLVv6aADU9FRdEvi0odABEDpPhQWAZpk=;
 b=SSCtRnD/5mipnkIMs7DSLXS84s9tRCe8DxYH656M/p8z9SogUy0FK0fxwasL8JoQ4ufQ
 TFdcMhVsytTnKdF9i19HNc34u2470UBI0pRk696GypJ1f5BvV/BGMn/YuQvFunGAE+Sl
 SGcqgNO4VWzHp9+5YXtkuU/5sX5Mr5jxFGy3o5hYIpvNmm6sngaJJnivvBH0mHiNXFCi
 vKxVQ8ESfIfxFNKdMjIDqwWG5Lvli9Lz24qn3PV+Jw/Clk4hjM9nMGIWhOZu+DZ5OzZ5
 TiT++xuw3a3lysueGL/sTwL/ff7UvRunvnpE+lhp2CH/dNEIHD9r95J9Mvh52S8d4kfk 8w== 
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xe139g0q1-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Apr 2024 19:48:29 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 43AH29JY029904;
	Wed, 10 Apr 2024 19:36:26 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3xbj7mer4n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Apr 2024 19:36:26 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 43AJaNLv21431036
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 10 Apr 2024 19:36:25 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 849025805F;
	Wed, 10 Apr 2024 19:36:23 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CA3B05805A;
	Wed, 10 Apr 2024 19:36:20 +0000 (GMT)
Received: from lingrow.int.hansenpartnership.com (unknown [9.67.87.107])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 10 Apr 2024 19:36:20 +0000 (GMT)
Message-ID: <0655cea93e52928d3e4a12b4fe2d2a4375492ed3.camel@linux.ibm.com>
Subject: Re: [REGRESSION] Loss of some SMART information in v6.1.81
From: James Bottomley <jejb@linux.ibm.com>
Reply-To: jejb@linux.ibm.com
To: Cyril Brulebois <kibi@debian.org>, regressions@lists.linux.dev,
        stable@vger.kernel.org
Cc: Mike Christie <michael.christie@oracle.com>,
        "Martin K. Petersen"
 <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>, gregkh@linuxfoundation.org,
        Bart Van Assche <bvanassche@acm.org>, Christoph
 Hellwig <hch@lst.de>,
        John Garry <john.g.garry@oracle.com>, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Diederik de Haas
 <didi.debian@cknow.org>,
        Salvatore Bonaccorso <carnil@debian.org>
Date: Wed, 10 Apr 2024 15:36:18 -0400
In-Reply-To: <20240410193207.qnb75osxuk4ovvm6@mraw.org>
References: <20240410193207.qnb75osxuk4ovvm6@mraw.org>
Content-Type: multipart/signed; micalg="pgp-sha256";
	protocol="application/pgp-signature"; boundary="=-jIeTBq4V93wWqSdiIOVb"
User-Agent: Evolution 3.42.4 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Fa6KIsnDCJKpkh_os9z_dR5k-l7EUFJp
X-Proofpoint-ORIG-GUID: Fa6KIsnDCJKpkh_os9z_dR5k-l7EUFJp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-10_04,2024-04-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011
 priorityscore=1501 lowpriorityscore=0 malwarescore=0 bulkscore=0
 spamscore=0 impostorscore=0 mlxscore=0 phishscore=0 suspectscore=0
 adultscore=0 mlxlogscore=999 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2404010000 definitions=main-2404100144


--=-jIeTBq4V93wWqSdiIOVb
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2024-04-10 at 21:32 +0200, Cyril Brulebois wrote:
> Hi,
>=20
> Munin uses the following command to get sensor-type information out
> of SMART-aware disks (e.g. temperature):
>=20
> =C2=A0=C2=A0=C2=A0 /usr/sbin/smartctl -A --nocheck=3Dstandby -d ata /dev/=
sda
>=20
> This broke following an upgrade from v6.1.76 (as found in Debian 12)
> to v6.1.82 (as currently found in the proposed-updates repository for
> the next point release of Debian 12), with smartctl's now reporting:
>=20
> =C2=A0=C2=A0=C2=A0 smartctl 7.3 2022-02-28 r5338 [x86_64-linux-6.1.0-19-a=
md64]
> (local build)
> =C2=A0=C2=A0=C2=A0 Copyright (C) 2002-22, Bruce Allen, Christian Franke,
> www.smartmontools.org
> =C2=A0=C2=A0=C2=A0=20
> =C2=A0=C2=A0=C2=A0 Device is in SLEEP mode, exit(2)
>=20
> This happens on baremetal with 2 pairs of disks:
> =C2=A0- 2=C3=97ST4000VN008-2DR1 (sda, sdb)
> =C2=A0- 2=C3=97ST8000VN004-2M21 (sdc, sdd)
>=20
> and that's an obvious lie with one pair doing system stuff and the
> other
> one doing media stuff.
>=20
> This also happens within a Debian 12 QEMU VM running on a Debian 12
> libvirt host, when using a SATA disk, which is what I've used to test
> various builds from the stable/linux-6.1.y branch and associated
> tags.
>=20
> Building stable releases, I pinpointed it as a regression between
> v6.1.80 and v6.1.81, then pinpointed it to commit cf33e6ca12d8.
>=20
> #regzbot introduced: v6.1.80..v6.1.81
> #regzbot introduced: cf33e6ca12d8
>=20
> This is also affecting v6.1.84 and v6.1.85 (released during my git
> bisect session).
>=20
> Reported in Debian via: https://bugs.debian.org/1068675=C2=A0(which
> included a trace with the distribution-provided v6.1.82 package).
>=20
> Most recent trace, with v6.1.85 (mainline, using the distribution's
> config but without any patches):
>=20
> =C2=A0=C2=A0=C2=A0 [=C2=A0=C2=A0 30.547027] ------------[ cut here ]-----=
-------
> =C2=A0=C2=A0=C2=A0 [=C2=A0=C2=A0 30.547034] WARNING: CPU: 0 PID: 697 at
> drivers/scsi/scsi_lib.c:214 scsi_execute_cmd+0x42/0x2c0 [scsi_mod]
> =C2=A0=C2=A0=C2=A0 [=C2=A0=C2=A0 30.547082] Modules linked in: tls tun in=
tel_rapl_msr
> intel_rapl_common kvm_intel kvm irqbypass ghash_clmulni_intel
> sha512_ssse3 sha512_generic sha256_ssse3 sha1_ssse3
> snd_hda_codec_generic ledtrig_audio snd_hda_intel snd_intel_dspcfg
> snd_intel_sdw_acpi aesni_intel snd_hda_codec crypto_simd cryptd rapl
> snd_hda_core snd_hwdep bochs drm_vram_helper pcspkr drm_ttm_helper
> snd_pcm iTCO_wdt snd_timer intel_pmc_bxt ttm iTCO_vendor_support snd
> watchdog soundcore virtio_console virtio_balloon drm_kms_helper
> button joydev evdev serio_raw sg binfmt_misc fuse loop drm efi_pstore
> dm_mod configfs qemu_fw_cfg virtio_rng ip_tables x_tables autofs4
> ext4 crc32c_generic crc16 mbcache jbd2 hid_generic usbhid hid sd_mod
> t10_pi crc64_rocksoft crc64 crc_t10dif crct10dif_generic ahci libahci
> virtio_scsi virtio_blk virtio_net net_failover failover xhci_pci
> crct10dif_pclmul crct10dif_common crc32_pclmul libata crc32c_intel
> xhci_hcd psmouse i2c_i801 i2c_smbus scsi_mod scsi_common lpc_ich
> virtio_pci
> =C2=A0=C2=A0=C2=A0 [=C2=A0=C2=A0 30.547194]=C2=A0 virtio_pci_legacy_dev v=
irtio_pci_modern_dev
> usbcore usb_common virtio virtio_ring
> =C2=A0=C2=A0=C2=A0 [=C2=A0=C2=A0 30.547205] CPU: 0 PID: 697 Comm: smartct=
l Not tainted 6.1.85
> #1
> =C2=A0=C2=A0=C2=A0 [=C2=A0=C2=A0 30.547210] Hardware name: QEMU Standard =
PC (Q35 + ICH9,
> 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
> =C2=A0=C2=A0=C2=A0 [=C2=A0=C2=A0 30.547217] RIP: 0010:scsi_execute_cmd+0x=
42/0x2c0 [scsi_mod]

This is a different manifestation of the same bug in stable that was
introduced by a backport of scsi_execute_cmd.  The proposed fix for the
domain validation problem here will also sort out this problem:

https://lore.kernel.org/linux-scsi/yq1frvvpymp.fsf@ca-mkp.ca.oracle.com/

James


--=-jIeTBq4V93wWqSdiIOVb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iHUEABMIAB0WIQTnYEDbdso9F2cI+arnQslM7pishQUCZhbqMgAKCRDnQslM7pis
hW3aAP9cB50hV7umpS8AXMm+EU6/C3B+X0AS2f7y6wZIGUfgDAEA02ZobSW6RlRI
1kbTb8SI4lt+YAiluDoI19ehkVz4rvI=
=JIJn
-----END PGP SIGNATURE-----

--=-jIeTBq4V93wWqSdiIOVb--


