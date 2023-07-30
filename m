Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 282A7768598
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jul 2023 15:30:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230121AbjG3Nam (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jul 2023 09:30:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230105AbjG3Nal (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jul 2023 09:30:41 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ECB01700
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jul 2023 06:30:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
 s=s31663417; t=1690723836; x=1691328636; i=aros@gmx.com;
 bh=l5krJ3jVttvwQkkfk6cfKWWfR1eKtB3g81VmPSj2Ekc=;
 h=X-UI-Sender-Class:Date:To:From:Subject;
 b=XuseGh+RbeY3H6gFebUMw71HjxguP0+z0NHYQNO4EmtvM3u7bIJk+9b5wNPNh9zOSmtGAkI
 rHCtheKUYUqazBbujxmzuFN3jaYZ6/i407cryxCdkh2drBKB4vpIslnizS/5ZGCSTmVN+WBRr
 x8KMIcjPMMBYp5tM7j1bk6y+czwjlKy1lK8A7SfEtbNnmzbEkQvSRZg/oMlgnCwKtvWWLhe/n
 U+dYXvEyGiZ3wsgq54xNylZOk1t73gSEzkyMpCdf5/NNhmDEcaSyWlwRjRbUYDmGuK1SQxsBa
 PMlnCbY2MiWP+BZ1qqAV9uYd8y7jgtlvE4iMjJzwFLUDB7uCc3OQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [10.35.110.16] ([98.159.234.36]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1M42jQ-1qQ6VH2wwS-0004Em; Sun, 30
 Jul 2023 15:30:35 +0200
Message-ID: <16a44663-808c-2eb4-ea6e-66f51a66f7cf@gmx.com>
Date:   Sun, 30 Jul 2023 13:30:34 +0000
MIME-Version: 1.0
Content-Language: en-US
To:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org
From:   "Artem S. Tashkinov" <aros@gmx.com>
Subject: Very bad bad firmware loading reporting situation
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:1pMQTssx+5e9+gHWi7B2riude2WpZ4J8wUFZSk6jFQYY0cOEdUA
 SmgvwyXZO7nrGCnlBEJR/xPSZbl0sdEfygKig/Jvfh0VaxdYslQ0x0aWqq2/Xg2p/sU4z/q
 j8Dje0uRZSkPBydcF0MW/ofPXn4RMONOmGi0edjTX8CcGU6fIBXVfHoBa9UpxAqGGiPhaJv
 mjWVzOARLpGbYIKuf0N4Q==
UI-OutboundReport: notjunk:1;M01:P0:joV5KZBTFc0=;G2qv5klkO8IRqXDRZd4vEArwMce
 zp053gDNhe8Ubt42P+1I2YKghs55ne1JxpoZc3cOFHYjyCHmbRMbsIBji5ksKARzWpj1F1sZP
 /illildiNDXgMvUJ3hEZpbLZZDDwYf9vQmCdVz/JDtatXR/1cw8Qf2Fmp2I1v++StAo53bExY
 ifgtkz0+uZJX1GaK8MD5wMHYtfZnxqsTbP32iURsORMD8cg+wF8yFN7ggOo1qlLoIfIFDPfq4
 xFleVLzOleqc2Ijr6uYyY7iFAZoZCgN4/NgAzfOmGS8PKRy1t3B7I77YNJC44ADxexZ7dZVai
 /tW24DVPvGu6DkUY+ENd9L+J1X2vcqbNNfzfHeb59uQu/PYOFIUcyY+2TIH+r3zVLg1lvgrVb
 7NNcKQFXbloXCfDBDPDMIZMOxA8isrJ5bMBjossYz/SkzHMHhCXQqogw9DG/Cla0BsbHE/2J6
 /+0AIfKckyHqVs8PdI74QlFs/gpqtOLqm0AA6A7l34UQ2q550YW7Ukd4P3aA+CeowmctMDGBx
 k/Iy4mwbe4blTIwZcoX3dCTooxn61ZkKMg17xyq/BPVrv1MjDGuOxWbkT1Xc++L6FZKXWU+bi
 7gA41pnrnulTc4ENer0WDWVGqtUCSzbMgGmMgzD3+eAbgJOHKfeh9ci6wxAlLhZSEKwD78sOC
 xc6Gb7OtuNteJo8Bzt603mP7u9mZOVlMP8EnhMWet0FEZdKLy43cK0T8odvf8o4JGq09D2fDP
 BzefZUV713/gbZPw/wowE5QGC6xaIxvMjItBOW/2hvFDnVDuRIEDXmKv8/YaIuCdLiGskFuNk
 iUSk8KdhVhSBn9mSBwiWXbszzd8sFNrNMnQQT+PXfZPUnlDkjqN5M8f0+Otvd0Mdg6ss+wmiR
 oB1Ng4xqnvb42GTT6waDF1aAVpe1kcRo2PiLaFBNx6WW7aZT5IjSjoyTKomHpQVhi4RNFDiGn
 OV03xicSIlxUdVohH4v8jdBNpE8=
X-Spam-Status: No, score=0.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_SBL,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi everyone,

I really dislike how firmware loading is handled by kernel [modules]:

* Many modules don't report which firmware files are getting loaded
* Often no information is reported in regard to firmware files
themselves, such as version, date or firmware file size. In a perfect
world it would be nice to at least see the CRC32 checksum of the
firmware file.
* Often bus and address are not clearly indicated.
* All the required firmware files must be probed simultaneously
(file_exists()) and reported if any of them are missing _before_
attempting to load any of them.   For instance missing firmware files
for the amdgpu driver may lead to a system instability or outright crashes=
.

This needs to change.

What I expect to see in `dmesg`:

module_name: PCI-e 0000:01:00.0 Loading firmware file
'directory/fw1.bin', version 1.2.3, size 12345 bytes
module_name: PCI-e 0000:01:00.0 Loading firmware file
'directory/fw2.bin', version <unversioned>, size 23456 bytes
module_name: PCI-e 0000:01:00.0 Loading firmware file
'directory/fw3.bin', version 1.0.0, size 4444 bytes

In case fw2.bin or fw3.bin is missing, the module must report that info
_before_ attempting to load any found/existing firmware files.

module_name: PCI-e 0000:01:00.0 Warning: missing firmware file
'directory/fw3.bin'
module_name: PCI-e 0000:01:00.0 Warning: missing firmware file
'directory/fw2.bin'
module_name: PCI-e 0000:01:00.0 Loading firmware file
'directory/fw1.bin', version 1.2.3, size 12345 bytes

As it currently stands firmware files are loaded on a one by one basis,
so in case you don't want to keep hundreds of megabytes of useless files
in /lib/firmware, several reboot attempts may be required to figure out
all the missing firmware files which is far from optimal.


Case in point:

cs35l41-hda i2c-CSC3551:00-cs35l41-hda.0: Cirrus Logic CS35L41 (35a40),
Revision: B2
cs35l41-hda i2c-CSC3551:00-cs35l41-hda.1: Reset line busy, assuming
shared reset
cs35l41-hda i2c-CSC3551:00-cs35l41-hda.1: Cirrus Logic CS35L41 (35a40),
Revision: B2
cs35l41-hda i2c-CSC3551:00-cs35l41-hda.0: xz decompression failed (xz_ret=
=3D6)
cs35l41-hda i2c-CSC3551:00-cs35l41-hda.0: Falling back to default firmware=
.

No information about firmware being requested whatsoever. No information
about bus or hardware device or maybe there is but it's hard to read.
There's no module named "cs35l41-hda".


Another example:

mt7921e 0000:01:00.0: enabling device (0000 -> 0002)
mt7921e 0000:01:00.0: ASIC revision: 79220010
mt7921e 0000:01:00.0: HW/SW Version: 0x8a108a10, Build Time: 2023062714370=
2a
mt7921e 0000:01:00.0: WM Firmware Version: ____000000, Build Time:
20230627143946

No information about firmware file(s) being loaded whatsoever. Actually
three files are being loaded by this device (Wi-Fi + BlueTooth).

This issue is tracked here:
https://bugzilla.kernel.org/show_bug.cgi?id=3D217734
