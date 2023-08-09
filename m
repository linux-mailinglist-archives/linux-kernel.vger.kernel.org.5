Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9B817768BD
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 21:27:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234074AbjHIT0u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 15:26:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233658AbjHIT0i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 15:26:38 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93D5B423B;
        Wed,  9 Aug 2023 12:25:51 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1bb84194bf3so1669395ad.3;
        Wed, 09 Aug 2023 12:25:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691609151; x=1692213951;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hgrUzHI5vFElj1uMt+qwY4hut4/wXqPQ3/5aob6WtDY=;
        b=Kgvir7UVgpNjhSrYZFSoy1mODLGrKeUEYseirWcnkmy3rHAEhIA5pM3idDM3N+9Zb9
         UPQ7/KBPwc7nHh6M9OFVyyiFs8Fzeafy0nfWlMrQJEc71zpvNG/0jT6k961KcB0dOZG2
         zQgUDnjjotgDHR0FE0YPNvg9WAlpEN0o1BvVLs/wmJ4sSe7xV6T+axgaeo/RwVwPO7Zm
         UZYzazpGcprfmLvmZSgFsgm4GoirUADu96kla+AqGVkdBAz2MeSxfmb/wo2Da5eocYxW
         2V3W50HmdJqHhntJWPehd1tk3UXYtiyEg92pDnwWzLklaUtxukW4jucS/2knlVOIhqJd
         iznw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691609151; x=1692213951;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hgrUzHI5vFElj1uMt+qwY4hut4/wXqPQ3/5aob6WtDY=;
        b=MRusd+mtrRU/+KUSVF7BMBEYJ0F+JlViK9Kq2he6rbLA9ukwL4dk+FVx8Pu+ezTZlq
         PB2Cut5NBVJNDk/om6SDv4ES/UgS8YfZvVndiRDVWn93Re4ITshRnbOTvQc/ZwBLOsq1
         uhSfeR97XMoA7F2xKjZak0vRmKKZ5cMiGUhSzlLVDljSTU9YjZhkPLV7Xd2APggbrQMp
         YvaW9f4q67sdC0y+NCIYnp1P8T9qzgsfmoVO2yAGrXYaux4JKiLzGEv9seTJvs68d6xh
         qppAGdixF+K+YU+N2y+SGb+PfE9epoAJs4/3l808x+uxQO5pZQtRY++Xy6A0k29qYLlL
         v+OQ==
X-Gm-Message-State: AOJu0Yyh6F9p+l2TXRnmabtwyP6VjsUMZD0bwclrvEEBRcRCVqLBdvZ4
        aIuj/3dLJ+VAHPNGfRDwH/s=
X-Google-Smtp-Source: AGHT+IHCh9SaVL8ALKEXvvWwpKGE+QAlwNjwOJ6Afmx2DRcPEM9bCfL4/fWZMM2jxGVdnuDUtJq0sg==
X-Received: by 2002:a17:902:868e:b0:1bb:3a7:6af7 with SMTP id g14-20020a170902868e00b001bb03a76af7mr46302plo.23.1691609150905;
        Wed, 09 Aug 2023 12:25:50 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id i12-20020a170902eb4c00b001b8ad8382a4sm11472198pli.216.2023.08.09.12.25.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Aug 2023 12:25:50 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Wed, 9 Aug 2023 12:25:48 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org,
        paulmck@kernel.org
Subject: Re: [PATCH 5.15 00/92] 5.15.126-rc1 review
Message-ID: <35e4b770-2ead-4a19-ad01-fa75996adef4@roeck-us.net>
References: <20230809103633.485906560@linuxfoundation.org>
 <20230809135326.GE3031656@google.com>
 <f47340c6-3c41-1f91-d0f9-fe0b59a23aac@roeck-us.net>
 <CAEXW_YQ4GqPwvUF8=8CWmdj=cD56v_eEVK-EirsObQXyBDFVpg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEXW_YQ4GqPwvUF8=8CWmdj=cD56v_eEVK-EirsObQXyBDFVpg@mail.gmail.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 09, 2023 at 02:35:59PM -0400, Joel Fernandes wrote:
> On Wed, Aug 9, 2023 at 12:18 PM Guenter Roeck <linux@roeck-us.net> wrote:
> >
> > On 8/9/23 06:53, Joel Fernandes wrote:
> > > On Wed, Aug 09, 2023 at 12:40:36PM +0200, Greg Kroah-Hartman wrote:
> > >> This is the start of the stable review cycle for the 5.15.126 release.
> > >> There are 92 patches in this series, all will be posted as a response
> > >> to this one.  If anyone has any issues with these being applied, please
> > >> let me know.
> > >>
> > >> Responses should be made by Fri, 11 Aug 2023 10:36:10 +0000.
> > >> Anything received after that time might be too late.
> > >>
> > >> The whole patch series can be found in one patch at:
> > >>      https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.126-rc1.gz
> > >> or in the git tree and branch at:
> > >>      git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
> > >> and the diffstat can be found below.
> > >
> > > Not necesscarily new with 5.15 stable but 3 of the 19 rcutorture scenarios
> > > hang with this -rc: TREE04, TREE07, TASKS03.
> > >
> > > 5.15 has a known stop machine issue where it hangs after 1.5 hours with cpu
> > > hotplug rcutorture testing. Me and tglx are continuing to debug this. The
> > > issue does not show up on anything but 5.15 stable kernels and neither on
> > > mainline.
> > >
> >
> > Do you by any have a crash pattern that we could possibly use to find the crash
> > in ChromeOS crash logs ? No idea if that would help, but it could provide some
> > additional data points.
> 
> The pattern shows as a hard hang, the system is unresponsive and all CPUs
> are stuck in stop_machine. Sometimes it recovers on its own from the
> hang and then RCU immediately gives stall warnings. It takes 1.5 hour
> to reproduce and sometimes never happens for several hours.
> 
> It appears related to CPU hotplug since gdb showed me most of the CPUs
> are spinning in multi_cpu_stop() / stop machine after the hang.
> 

Hmm, we do see lots of soft lockups with multi_cpu_stop() in the backtrace,
but not with v5.15.y but with v5.4.y. The actual hang is in stop_machine_yield().
Example:

<0>[63298.624328] watchdog: BUG: soft lockup - CPU#0 stuck for 11s! [migration/0:11]
<4>[63298.624331] Modules linked in: 8021q ccm snd_seq_dummy snd_seq snd_seq_device bridge stp llc tun nf_nat_tftp nf_conntrack_tftp nf_nat_ftp nf_conntrack_ftp esp6 ah6 ip6t_REJECT ip6t_ipv6header vhost_vsock vhost vmw_vsock_virtio_transport_common vsock veth rfcomm xt_cgroup cmac algif_hash algif_skcipher af_alg xt_MASQUERADE uinput iwlmvm snd_soc_skl_ssp_clk iwl7000_mac80211 btusb snd_soc_kbl_da7219_max98357a btrtl btintel snd_soc_hdac_hdmi btbcm bluetooth snd_soc_dmic snd_soc_skl ecdh_generic ecc snd_soc_sst_ipc snd_soc_sst_dsp snd_soc_hdac_hda uvcvideo snd_soc_acpi_intel_match snd_soc_acpi snd_hda_ext_core videobuf2_vmalloc videobuf2_v4l2 videobuf2_common snd_intel_dspcfg videobuf2_memops snd_hda_codec snd_hwdep snd_hda_core iwlwifi snd_soc_da7219 snd_soc_max98357a fuse ip6table_nat cfg80211 lzo_rle lzo_compress zram joydev
<4>[63298.624357] CPU: 0 PID: 11 Comm: migration/0 Tainted: G     U  W         5.4.180-17902-g44152654f29b #1
<4>[63298.624358] Hardware name: Google Nami/Nami, BIOS Google_Nami.10775.145.0 09/19/2019
<4>[63298.624363] RIP: 0010:stop_machine_yield+0xb/0xd
<4>[63298.624366] Code: ff 74 b6 f0 ff 0f 75 b1 48 83 c7 08 e8 1f cb f9 ff eb a6 e8 a0 20 e3 ff eb bc e8 50 4b f5 ff 0f 1f 44 00 00 55 48 89 e5 f3 90 <5d> c3 0f 1f 44 00 00 55 48 89 e5 41 57 41 56 41 55 41 54 53 48 81
<4>[63298.624368] RSP: 0000:ffffbaf90006fe38 EFLAGS: 00000293 ORIG_RAX: ffffffffffffff13
<4>[63298.624370] RAX: 0000000000000000 RBX: ffffbaf90300bca8 RCX: 0000000000000000
<4>[63298.624371] RDX: 0000000000000000 RSI: 0000000000000008 RDI: ffffffffb0d46920
<4>[63298.624373] RBP: ffffbaf90006fe38 R08: 0000000000000002 R09: 0000398ecf9a0ac5
<4>[63298.624374] R10: 0000000000000171 R11: ffffffffaf9cfb11 R12: 0000000000000001
<4>[63298.624376] R13: ffff9b09baa22201 R14: ffffffffb0d46920 R15: 0000000000000001
<4>[63298.624377] FS:  0000000000000000(0000) GS:ffff9b09baa00000(0000) knlGS:0000000000000000
<4>[63298.624379] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
<4>[63298.624380] CR2: 0000153c00724820 CR3: 0000000171ab8005 CR4: 00000000003606f0
<4>[63298.624382] Call Trace:
<4>[63298.624386]  multi_cpu_stop+0x89/0x119
<4>[63298.624389]  ? stop_two_cpus+0x24d/0x24d
<4>[63298.624391]  cpu_stopper_thread+0x8f/0x111
<4>[63298.624394]  smpboot_thread_fn+0x174/0x212
<4>[63298.624397]  kthread+0x147/0x156
<4>[63298.624399]  ? cpu_report_death+0x43/0x43
<4>[63298.624401]  ? kthread_blkcg+0x2e/0x2e
<4>[63298.624404]  ret_from_fork+0x35/0x40
<0>[63298.624407] Kernel panic - not syncing: softlockup: hung tasks

I guess that is something different ?

Guenter
