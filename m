Return-Path: <linux-kernel+bounces-14923-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECE0082247B
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 23:08:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EDB921C22D07
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 22:08:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16EDB1A70D;
	Tue,  2 Jan 2024 22:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foundries.io header.i=@foundries.io header.b="JE5dz+zw"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85DD61A70C
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jan 2024 22:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=foundries.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foundries.io
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-40d5b89e2bfso59751635e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jan 2024 14:02:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=foundries.io; s=google; t=1704232922; x=1704837722; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=7S3efX1yIZagbg2fenKkLilk70fcwzMsPCYsmFfcYGs=;
        b=JE5dz+zw6E2StDp322mtwuJJvRn7m1JqcIkCdySVFP3Y38mzIzvOJvF56YYAhXEVmw
         xIeqTQaEBthb/kTle12eSJulFtTY8N0YFYm9pGASe/KyjlHqkiKuCYiyMtyZgAxGYP0g
         JfRV5cXyVQM18fCkC+kkUQoGq++k5Zy/nyEqtlfnFrO6vBU4QwAmwSptKaTiKrNN2OUO
         I+E/H3RVOJ1HwxG/CGt2G7KcwT0q5rbjKSTJWilkOur1ssmIS1eo7P7BVfZKbZH8KiHY
         vK4ETlBey4z17TWexo447pKtqnothsbyK5vR5opkB9Z3iLr5EgA9ZPSkkkIsQ9diP+5a
         8Uxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704232922; x=1704837722;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7S3efX1yIZagbg2fenKkLilk70fcwzMsPCYsmFfcYGs=;
        b=lDlox0wMIRnI6ln2PQcpPYN+jWRc6BeZ8S79HpzdXNrwL1iugMi/9w7bplcUIFWCZg
         W6yBFmaU4Q95+U1JtlvPsIqwLKZ0Ye13cP4KO04ZN+qvndQlJQ8P+A4b6jZoW+li4/r3
         slb2y8qhj4wD7gtWjOuV4zmCaUV/PEsZBIDxuy+yWwSrV1d/onv4g60W3JD0JldGoY7M
         PMhgoYnisiy3jKUN+RhOSO3YHYwO/gzMvoFclwR3WW3Mfu01xWYuQGjYCn+DukxtSDyl
         D83opZa7GSAZBzdDYpX/hEVFkm/90CgYU0DSrqUtZduTzdltSAk8ZpXT1S66fkcn/lfX
         ijAA==
X-Gm-Message-State: AOJu0Yz8TttXa8eSAdjFRlm9DnfbGIFXMjcJeLUfL79lyPVo3Nxz3WQ7
	m/jI9CxjSgD/gXu6V8WJDCTEFYJCw7fBIQ==
X-Google-Smtp-Source: AGHT+IGNkUnAZa0uASY2Y45RW0Q+BStpcJ1pwcO/Vpet4jC5rWk9WI5Fdfi608/jy+Rx+vsGMBP2mQ==
X-Received: by 2002:a05:600c:4504:b0:40d:8846:bbce with SMTP id t4-20020a05600c450400b0040d8846bbcemr1826422wmo.58.1704232921468;
        Tue, 02 Jan 2024 14:02:01 -0800 (PST)
Received: from trax (96.red-79-144-190.dynamicip.rima-tde.net. [79.144.190.96])
        by smtp.gmail.com with ESMTPSA id m1-20020a05600c4f4100b0040d5b849f38sm303739wmq.0.2024.01.02.14.02.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jan 2024 14:02:00 -0800 (PST)
From: "Jorge Ramirez-Ortiz, Foundries" <jorge@foundries.io>
X-Google-Original-From: "Jorge Ramirez-Ortiz, Foundries" <JorgeRamirez-Ortiz>
Date: Tue, 2 Jan 2024 23:01:59 +0100
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: "Jorge Ramirez-Ortiz, Foundries" <jorge@foundries.io>,
	Avri Altman <Avri.Altman@wdc.com>,
	"ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
	"christian.loehle@arm.com" <christian.loehle@arm.com>,
	"jinpu.wang@ionos.com" <jinpu.wang@ionos.com>,
	"axboe@kernel.dk" <axboe@kernel.dk>,
	"beanhuo@micron.com" <beanhuo@micron.com>,
	"yibin.ding@unisoc.com" <yibin.ding@unisoc.com>,
	"victor.shih@genesyslogic.com.tw" <victor.shih@genesyslogic.com.tw>,
	"asuk4.q@gmail.com" <asuk4.q@gmail.com>,
	"hkallweit1@gmail.com" <hkallweit1@gmail.com>,
	"yangyingliang@huawei.com" <yangyingliang@huawei.com>,
	"yebin10@huawei.com" <yebin10@huawei.com>,
	"linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mmc: rpmb: do not force a retune before RPMB switch
Message-ID: <ZZSH1ykwP45fZaLh@trax>
References: <20231204150111.3320071-1-jorge@foundries.io>
 <f83933d3-6426-425c-903e-abbd2691e84a@intel.com>
 <DM6PR04MB6575A30D162378E82B4D7DDEFC84A@DM6PR04MB6575.namprd04.prod.outlook.com>
 <ZXBGTxS7sUSILtLs@trax>
 <ZXbBhjZIn5sj6EYO@trax>
 <ZZPoRPxdWXuT+cEo@trax>
 <b88eca08-7f20-4287-802c-ae1c8e3cd5cf@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b88eca08-7f20-4287-802c-ae1c8e3cd5cf@intel.com>

On 02/01/24 21:01:52, Adrian Hunter wrote:
> On 2/01/24 12:41, Jorge Ramirez-Ortiz, Foundries wrote:
> > On 11/12/23 09:00:06, Jorge Ramirez-Ortiz, Foundries wrote:
> >> On 06/12/23 11:00:47, Jorge Ramirez-Ortiz, Foundries wrote:
> >>> On 06/12/23 07:02:43, Avri Altman wrote:
> >>>>>
> >>>>> On 4/12/23 17:01, Jorge Ramirez-Ortiz wrote:
> >>>>>> Requesting a retune before switching to the RPMB partition has been
> >>>>>> observed to cause CRC errors on the RPMB reads (-EILSEQ).
> >>>>>
> >>>>> There are still 2 concerns:
> >>>>> 1) We don't really know the root cause.  Have you determined if here are
> >>>>> CRC errors in the main partition also?
> >>>
> >>> right, and I don't disagree with that.
> >>>
> >>> As a test I created a 4GB file from /dev/random which I then copied
> >>> several times (dd if= ....)
> >>>
> >>> root@uz3cg-dwg-sec:/sys/kernel/debug/mmc0# cat err_stats
> >>> # Command Timeout Occurred:      0
> >>> # Command CRC Errors Occurred:   0
> >>> # Data Timeout Occurred:         0
> >>> # Data CRC Errors Occurred:      0
> >>> # Auto-Cmd Error Occurred:       0
> >>> # ADMA Error Occurred:   0
> >>> # Tuning Error Occurred:         0
> >>> # CMDQ RED Errors:       0
> >>> # CMDQ GCE Errors:       0
> >>> # CMDQ ICCE Errors:      0
> >>> # Request Timedout:      0
> >>> # CMDQ Request Timedout:         0
> >>> # ICE Config Errors:     0
> >>> # Controller Timedout errors:    0
> >>> # Unexpected IRQ errors:         0
> >>>
> >>> However as soon as I access RPMB and fails (it takes just a few tries) I see:
> >>>
> >>> I/TC: RPMB: Using generated key
> >>> [   86.902118] sdhci-arasan ff160000.mmc: __mmc_blk_ioctl_cmd: data error -84
> >>> E/TC:? 0
> >>> E/TC:? 0 TA panicked with code 0xffff0000
> >>> E/LD:  Status of TA 22250a54-0bf1-48fe-8002-7b20f1c9c9b1
> >>> E/LD:   arch: aarch64
> >>> E/LD:  region  0: va 0xc0004000 pa 0x7e200000 size 0x002000 flags rw-s (ldelf)
> >>> E/LD:  region  1: va 0xc0006000 pa 0x7e202000 size 0x008000 flags r-xs (ldelf)
> >>> E/LD:  region  2: va 0xc000e000 pa 0x7e20a000 size 0x001000 flags rw-s (ldelf)
> >>> E/LD:  region  3: va 0xc000f000 pa 0x7e20b000 size 0x004000 flags rw-s (ldelf)
> >>> E/LD:  region  4: va 0xc0013000 pa 0x7e20f000 size 0x001000 flags r--s
> >>> E/LD:  region  5: va 0xc0014000 pa 0x7e22c000 size 0x005000 flags rw-s (stack)
> >>> E/LD:  region  6: va 0xc0019000 pa 0x818ea9ba8 size 0x002000 flags rw-- (param)
> >>> E/LD:  region  7: va 0xc001b000 pa 0x818e97ba8 size 0x001000 flags rw-- (param)
> >>> E/LD:  region  8: va 0xc004f000 pa 0x00001000 size 0x014000 flags r-xs [0]
> >>> E/LD:  region  9: va 0xc0063000 pa 0x00015000 size 0x008000 flags rw-s [0]
> >>> E/LD:   [0] 22250a54-0bf1-48fe-8002-7b20f1c9c9b1 @ 0xc004f000
> >>> E/LD:  Call stack:
> >>> E/LD:   0xc0051a14
> >>> E/LD:   0xc004f31c
> >>> E/LD:   0xc0052d40
> >>> E/LD:   0xc004f624
> >>>
> >>> root@uz3cg-dwg-sec:/var/rootdirs/home/fio# cat /sys/kernel/debug/mmc0/err_stats
> >>> # Command Timeout Occurred:      0
> >>> # Command CRC Errors Occurred:   0
> >>> # Data Timeout Occurred:         0
> >>> # Data CRC Errors Occurred:      1
> >>> # Auto-Cmd Error Occurred:       0
> >>> # ADMA Error Occurred:   0
> >>> # Tuning Error Occurred:         0
> >>> # CMDQ RED Errors:       0
> >>> # CMDQ GCE Errors:       0
> >>> # CMDQ ICCE Errors:      0
> >>> # Request Timedout:      0
> >>> # CMDQ Request Timedout:         0
> >>> # ICE Config Errors:     0
> >>> # Controller Timedout errors:    0
> >>> # Unexpected IRQ errors:         0
> >>>
> >>>>> 2) Forcing this on everyone
> >>>>>
> >>>>> The original idea was that because re-tuning cannot be done in RPMB, the
> >>>>> need to re-rune in RPMB could be avoided by always re-tuning before
> >>>>> switching to RPMB and then switching straight back. IIRC re-tuning should
> >>>>> guarantee at least 4MB more I/O without issue.
> >>>> Performance is hardly an issue in the context of RPMB access -
> >>>> For most cases it’s a single frame.
> >>>
> >>> Yes, the security use case typically stores hashes, variables
> >>> (bootcount, upgrade_available, versions, that sort of thing) and
> >>> certificates in RPMB.
> >>>
> >>> Since you mentioned, I am seeing that tuning before switching to RPMB
> >>> has an impact on performance. As a practical test, just reading a 6 byte
> >>> variable incurs in 50ms penalty in kernel space due to the need to
> >>> retune 5 times. Not great since the request is coming from a Trusted
> >>> Application via OP-TEE through the supplicant meaning this TEE thread
> >>> (they are statically allocated CFG_NUM_THREADS) will be reserved for
> >>> quite a bit of time.
> >>>
> >>> Roughly:
> >>> TA --> OP-TEE (core) --> TEE-supplicant --> Kernel (>50ms) --> OP-TEE --> TA
> >>
> >> To add more detail to the timing above, when using RPMB, OP-TEE stores
> >> the secure filesystem on RPMB as well, so accessing one of the variables
> >> stored in the filesystem consists on a number (~5) of individual RPMB
> >> requests (each one forcing a retune, each retune taking around 10ms).
> >
> > Adrian, please could you comment on the above.
> >
> > The current code is a performance drag for systems that implement their
> > secure filesystems on RPMB (i.e: OP-TEE) causing each read operation (of
> > variables consisting of a few bytes stored in such a filesystem) to
> > perform 5 consecutive retune requests.
> >
> > I am just thinking whether the original use case that forces a call to
> > retune prior to processing the RPMB request remains valid.
>
> I am not sure what you are asking.
>
> For some transfer modes, re-tuning is expected to deal with sampling
> point drift over time, mainly due to temperature changes.  It is done
> either periodically (tuning timer) or after a CRC error.
>
> There is no reason to assume RPMB is immune from that.
>
> Certainly re-tuning before switching to RPMB is not optimal for
> performance, and we can leave that out, but a CRC error before
> or during RPMB operations will *still* result in re-tuning
> after switching back from RPMB.
>
> In your case, re-tuning makes things worse, which is a bit of a
> mystery.  Running the new re-tuning test would tell us whether
> it makes things worse in general, or only for RPMB.
>
> >
> > Independently of the fact that not doing so fixes the problem I was
> > working on - and with the information I have - I dont think RPMB is
> > generally used to store larger files (maybe you have more information
> > about the average use case? are you aware of systems using RPMB to store
> > binaries or images?)
> >
> > I still I have to execute the test you shared some weeks ago. Bit of a
> > pain to NFS boot this system...will try to do it this week.
>
> Other options are to boot with an initrd only, or after boot switch
> to a RAM-based file system.
>
> I was waiting for this, since it is good to try to get closer to a
> root cause, but as you point out, the change is good for performance
> also, so I will Ack it.

great, thanks!
I was finally able to nfs mount this project (was a bit of a pain since
the board is using ostree).

The test failed. See below

root@uz3cg-dwg-sec:/# uname -a
Linux uz3cg-dwg-sec 5.15.64-lmp-standard #1 SMP Thu Sep 1 02:40:19 UTC 2022 aarch64 GNU/Linux

root@uz3cg-dwg-sec:/# cat /proc/cmdline
earlycon console=ttyPS0,115200 clk_ignore_unused root=/dev/nfs nfsroot=192.168.1.9:/srv/nfs/rootfs rootwait rw nfsrootdebug ip=dhcp rootfstype=ext4 ostree=ostree/boot.1.1/lmp/5c73dc21eb70c12363747b90c04302115715fa46063a9099841cf23cc70c09a6/0

root@uz3cg-dwg-sec:/sys/bus/mmc/drivers# cd mmcblk/

root@uz3cg-dwg-sec:/sys/bus/mmc/drivers/mmcblk# ls
bind       mmc0:0001  uevent     unbind

root@uz3cg-dwg-sec:/sys/bus/mmc/drivers/mmcblk# echo 'mmc0:0001' > unbind

root@uz3cg-dwg-sec:/sys/bus/mmc/drivers# echo 'mmc0:0001' > mmc_test/bind
[  284.253261] mmc_test mmc0:0001: Card claimed for testing.

root@uz3cg-dwg-sec:/sys/bus/mmc/drivers# cd ..
root@uz3cg-dwg-sec:/sys/bus/mmc# ls
devices            drivers            drivers_autoprobe  drivers_probe      uevent

root@uz3cg-dwg-sec:/sys/bus/mmc# cd /

root@uz3cg-dwg-sec:/# cat /sys/kernel/debug/mmc0/mmc0\:0001/test
test      testlist

root@uz3cg-dwg-sec:/# cat /sys/kernel/debug/mmc0/mmc0\:0001/testlist | grep tuning
52:     Re-tuning reliability

root@uz3cg-dwg-sec:/# echo 52 > /sys/kernel/debug/mmc0/mmc0\:0001/test
[  352.283447] mmc0: Starting tests of card mmc0:0001...
[  352.288597] mmc0: Test case 52. Re-tuning reliability...
[  354.265441] mmc0: Result: ERROR (-84)
[  354.269142] mmc0: Tests completed.

root@uz3cg-dwg-sec:/#




>
>
> >
> > TIA
> >
> >>
> >> BTW, I also tried delaying the timing between those consecutive retunes
> >> (up to 1 second), but the issue still persisted.
> >>
> >>>
> >>> Adrian, I couldn't find the original performance justification for
> >>> enabling this feature globally. At which point do you think it becomes
> >>> beneficial to retune before accessing RPMB?
> >>
> >> How should we proceed with this patch then? can it be merged as I
> >> proposed? should I rewrite it differently? not sure what is next
> >>
> >> TIA
> >> Jorge
>

