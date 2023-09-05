Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96D9B792D4F
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 20:19:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241047AbjIESTl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 14:19:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbjIESTi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 14:19:38 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 282B17AAF
        for <linux-kernel@vger.kernel.org>; Tue,  5 Sep 2023 11:08:15 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id 38308e7fff4ca-2bcfd3220d3so42113481fa.2
        for <linux-kernel@vger.kernel.org>; Tue, 05 Sep 2023 11:08:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linbit-com.20230601.gappssmtp.com; s=20230601; t=1693937180; x=1694541980; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=toLHVDzgNaAzaAmVAyotDH7xDpEMacIl37ejxJnj4NM=;
        b=pXN36SnVXOFoC3mxv/Xyx6RE6GkU592Qx191dwmBgWVeQ9loSt+f0UF4akWuFZSXJS
         SKoKKtuP0k3jF3d7ihhX8TVbyTIQgRa4sUmCOivhWGlQkbfVOVl5qrSAZJnW1ssNycQk
         l2BvqajtiIHi1sUXkjlziqr0mpQgU3sH4rIC3uyZgeLSRZ8Lkf7um9OXrWOJgaw52YiQ
         wLx7fbQ8yVZCzsgRvJRGDuthwqheP2Zv3TUyV33mbI7i4jGFuJpWrAEg4+5oDZcSKoQu
         Xk+Xp+cGeqBaNmmodg4+Kjj0i3qyxgsSfP6UFqSye8lNyywqLmsIBYDXu6lgLQo0TRUj
         EGew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693937180; x=1694541980;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=toLHVDzgNaAzaAmVAyotDH7xDpEMacIl37ejxJnj4NM=;
        b=TaPrFbcaN5EG4b/PqzOa8gqWHNgp/uffPuvBMofPFNwKeeUfKwYouqC3aQL4AJsuSl
         AZ4jGZ1l2NxMlY9x1RlZmtIxnAIi0l79+OkHcUiVRBH6jjplv26G+WdZXawwX3tpipCx
         EegsO9CSaMa75QDEikS3TTYIWbb6Txe4m1/F/VV3dp8TYYVP5urXZwHxeoxjQzFAKql4
         k+VtdKQjR/6ynZxAcU3Sfm+Xj4+FAZYNDO8sZjwoM9CEZWevJ0CxNy2RGtb+4tMnuC3o
         Z7qQJxSFCPwzf9MAdoTonoOTpmS5QYOFF/s9HOBEifyfvZloXQRxG8ZKLTXe0nunLH49
         mqZA==
X-Gm-Message-State: AOJu0YzR3TCtKF0paCQETWz4maPVt2fFL0p/sCEskPtOrd+7cOwRsPV1
        uMGFFl6GVC8o60Ifhi7delWa7mRRjCfd9xTM6J6KeUHq
X-Google-Smtp-Source: AGHT+IEeOxfQYdFYPLVeZB4D3mT3jO5bhrV7jF88hHN5iig58fkbLVRyPDxhTuyhWPKmcgXFJNnjbw==
X-Received: by 2002:a17:906:5a59:b0:9a4:dd49:da3e with SMTP id my25-20020a1709065a5900b009a4dd49da3emr413456ejc.68.1693934656736;
        Tue, 05 Sep 2023 10:24:16 -0700 (PDT)
Received: from [192.168.178.55] (h082218028181.host.wavenet.at. [82.218.28.181])
        by smtp.gmail.com with ESMTPSA id e6-20020a17090681c600b00992a8a54f32sm7791342ejx.139.2023.09.05.10.24.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Sep 2023 10:24:16 -0700 (PDT)
Message-ID: <525c0143-4f72-31c3-8a83-ee29c699e1e7@linbit.com>
Date:   Tue, 5 Sep 2023 19:24:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: DRBD broken in kernel 6.5 and 6.5.1
To:     Linux regressions mailing list <regressions@lists.linux.dev>,
        Serguei Ivantsov <manowar@gsc-game.com>
Cc:     Philipp Reisner <philipp.reisner@linbit.com>,
        Lars Ellenberg <lars.ellenberg@linbit.com>,
        drbd-dev@lists.linbit.com, LKML <linux-kernel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>
References: <CAKH+VT3YLmAn0Y8=q37UTDShqxDLsqPcQ4hBMzY7HPn7zNx+RQ@mail.gmail.com>
 <c6282b47-114d-7bd7-6efb-856d76bea128@leemhuis.info>
Content-Language: en-US
From:   =?UTF-8?Q?Christoph_B=c3=b6hmwalder?= 
        <christoph.boehmwalder@linbit.com>
In-Reply-To: <c6282b47-114d-7bd7-6efb-856d76bea128@leemhuis.info>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 03.09.23 um 07:45 schrieb Linux regression tracking (Thorsten Leemhuis):
> CCing the DRBD maintainers and the appropriate lists, as they should
> know about this -- or actually might know what is causing this already
> or be able to guess the cause. For the rest of this mail:
> 
> [TLDR: I'm adding this report to the list of tracked Linux kernel
> regressions; the text you find below is based on a few templates
> paragraphs you might have encountered already in similar form.]
> 
> On 02.09.23 22:37, Serguei Ivantsov wrote:
>> Hello,
>>
>> After upgrading the kernel to 6.5 the system can't connect to the peer
>> (6.4.11) anymore.
>> I checked 6.5.1 - same issue.
>> All previous kernels including 6.4.14 are working just fine.
>> Checking the 6.5 changelog, I found commit
>> 9ae440b8fdd6772b6c007fa3d3766530a09c9045 which mentioned some changes
>> to DRBD.
>>
>> On the 6.5.X system I have the following in the kernel log
>> (drbd_send_block() failed):
>>
>> [    2.473497] drbd: initialized. Version: 8.4.11 (api:1/proto:86-101)
>>
>> [    2.475394] drbd: built-in
>>
>> [    2.477254] drbd: registered as block device major 147
>>
>> [    7.421400] drbd drbd0: Starting worker thread (from drbdsetup-84 [3844])
>>
>> [    7.421509] drbd drbd0/0 drbd0: disk( Diskless -> Attaching )
>>
>> [    7.421552] drbd drbd0: Method to ensure write ordering: flush
>>
>> [    7.421554] drbd drbd0/0 drbd0: max BIO size = 131072
>>
>> [    7.421557] drbd drbd0/0 drbd0: drbd_bm_resize called with capacity
>> == 1845173184
>>
>> [    7.428017] drbd drbd0/0 drbd0: resync bitmap: bits=230646648
>> words=3603854 pages=7039
>>
>> [    7.467370] drbd0: detected capacity change from 0 to 1845173184
>>
>> [    7.467372] drbd drbd0/0 drbd0: size = 880 GB (922586592 KB)
>>
>> [    7.486005] drbd drbd0/0 drbd0: recounting of set bits took
>> additional 0 jiffies
>>
>> [    7.486010] drbd drbd0/0 drbd0: 0 KB (0 bits) marked out-of-sync by
>> on disk bit-map.
>>
>> [    7.486017] drbd drbd0/0 drbd0: disk( Attaching -> UpToDate )
>>
>> [    7.486021] drbd drbd0/0 drbd0: attached to UUIDs
>> 32DDB2019708F68A:0000000000000000:7D97648599B446DD:7D96648599B446DD
>>
>> [    7.486863] drbd drbd0: conn( StandAlone -> Unconnected )
>>
>> [    7.486871] drbd drbd0: Starting receiver thread (from drbd_w_drbd0 [3847])
>>
>> [    7.486918] drbd drbd0: receiver (re)started
>>
>> [    7.486929] drbd drbd0: conn( Unconnected -> WFConnection )
>>
>> [   12.340212] drbd drbd0: initial packet S crossed
>>
>> [   22.310856] drbd drbd0: Handshake successful: Agreed network
>> protocol version 101
>>
>> [   22.311087] drbd drbd0: Feature flags enabled on protocol level:
>> 0xf TRIM THIN_RESYNC WRITE_SAME WRITE_ZEROES.
>>
>> [   22.311425] drbd drbd0: conn( WFConnection -> WFReportParams )
>>
>> [   22.311621] drbd drbd0: Starting ack_recv thread (from drbd_r_drbd0 [4071])
>>
>> [   22.400702] drbd drbd0/0 drbd0: drbd_sync_handshake:
>>
>> [   22.400869] drbd drbd0/0 drbd0: self
>> 32DDB2019708F68A:0000000000000000:7D97648599B446DD:7D96648599B446DD
>> bits:0 flags:0
>>
>> [   22.401205] drbd drbd0/0 drbd0: peer
>> 32DDB2019708F68A:0000000000000000:7D97648599B446DC:7D96648599B446DD
>> bits:0 flags:0
>>
>> [   22.401538] drbd drbd0/0 drbd0: uuid_compare()=0 by rule 40
>>
>> [   22.401709] drbd drbd0/0 drbd0: peer( Unknown -> Secondary ) conn(
>> WFReportParams -> Connected ) pdsk( DUnknown -> UpToDate )
>>
>> [   22.415394] drbd drbd0/0 drbd0: role( Secondary -> Primary )
>>
>> [   22.506540] drbd drbd0/0 drbd0: _drbd_send_page: size=4096 len=4096 sent=-5
>>
>> [   22.506773] drbd drbd0: peer( Secondary -> Unknown ) conn(
>> Connected -> NetworkFailure ) pdsk( UpToDate -> DUnknown )
>>
>> [   22.507109] drbd drbd0/0 drbd0: new current UUID
>> 7F8B15C04AF49C4D:32DDB2019708F68B:7D97648599B446DD:7D96648599B446DD
>>
>> [   22.507451] drbd drbd0: ack_receiver terminated
>>
>> [   22.507588] drbd drbd0: Terminating drbd_a_drbd0
>>
>> [   22.600693] drbd drbd0: Connection closed
>>
>> [   22.600937] drbd drbd0: conn( NetworkFailure -> Unconnected )
>>
>> [   22.601115] drbd drbd0: receiver terminated
>>
>> [   22.601238] drbd drbd0: Restarting receiver thread
>>
>> [   22.601378] drbd drbd0: receiver (re)started
>>
>> [   22.601508] drbd drbd0: conn( Unconnected -> WFConnection )
>>
>> [   23.260624] drbd drbd0: Handshake successful: Agreed network
>> protocol version 101
>>
>> [   23.260859] drbd drbd0: Feature flags enabled on protocol level:
>> 0xf TRIM THIN_RESYNC WRITE_SAME WRITE_ZEROES.
>>
>> [   23.261187] drbd drbd0: conn( WFConnection -> WFReportParams )
>>
>> [   23.261367] drbd drbd0: Starting ack_recv thread (from drbd_r_drbd0 [4071])
>>
>> [   23.340593] drbd drbd0/0 drbd0: drbd_sync_handshake:
>>
>> [   23.340771] drbd drbd0/0 drbd0: self
>> 7F8B15C04AF49C4D:32DDB2019708F68B:7D97648599B446DD:7D96648599B446DD
>> bits:1 flags:0
>>
>> [   23.341192] drbd drbd0/0 drbd0: peer
>> 32DDB2019708F68A:0000000000000000:7D97648599B446DC:7D96648599B446DD
>> bits:0 flags:0
>>
>> [   23.341649] drbd drbd0/0 drbd0: uuid_compare()=1 by rule 70
>>
>> [   23.341824] drbd drbd0/0 drbd0: peer( Unknown -> Secondary ) conn(
>> WFReportParams -> WFBitMapS ) pdsk( DUnknown -> Consistent )
>>
>> [   23.344911] drbd drbd0/0 drbd0: send bitmap stats [Bytes(packets)]:
>> plain 0(0), RLE 23(1), total 23; compression: 100.0%
>>
>> [   23.396792] drbd drbd0/0 drbd0: receive bitmap stats
>> [Bytes(packets)]: plain 0(0), RLE 23(1), total 23; compression: 100.0%
>>
>> [   23.397210] drbd drbd0/0 drbd0: helper command: /sbin/drbdadm
>> before-resync-source minor-0
>>
>> [   23.407965] drbd drbd0/0 drbd0: helper command: /sbin/drbdadm
>> before-resync-source minor-0 exit code 0 (0x0)
>>
>> [   23.417547] drbd drbd0/0 drbd0: conn( WFBitMapS -> SyncSource )
>> pdsk( Consistent -> Inconsistent )
>>
>> [   23.426697] drbd drbd0/0 drbd0: Began resync as SyncSource (will
>> sync 4 KB [1 bits set]).
>>
>> [   23.435638] drbd drbd0/0 drbd0: updated sync UUID
>> 7F8B15C04AF49C4D:32DEB2019708F68B:32DDB2019708F68B:7D97648599B446DD
>>
>> [   23.488608] drbd drbd0/0 drbd0: _drbd_send_page: size=4096 len=4096 sent=-5
>>
>> [   23.498182] drbd drbd0/0 drbd0: drbd_send_block() failed
>>
>> [   23.508498] drbd drbd0: peer( Secondary -> Unknown ) conn(
>> SyncSource -> NetworkFailure )
>>
>> [   23.517597] drbd drbd0: ack_receiver terminated
>>
>> [   23.527513] drbd drbd0: Terminating drbd_a_drbd0
>>
>> [   23.690598] drbd drbd0: Connection closed
>>
>> [   23.701857] drbd drbd0: conn( NetworkFailure -> Unconnected )
>>
>> [   23.712017] drbd drbd0: receiver terminated
>>
>> [   23.721597] drbd drbd0: Restarting receiver thread
>>
>>
>>
>> On the peer:
>>
>>
>> [349071.038278] drbd drbd0: conn( Unconnected -> WFConnection )
>>
>> [349071.558245] drbd drbd0: Handshake successful: Agreed network
>> protocol version 101
>>
>> [349071.562105] drbd drbd0: Feature flags enabled on protocol level:
>> 0xf TRIM THIN_RESYNC WRITE_SAME WRITE_ZEROES.
>>
>> [349071.569889] drbd drbd0: conn( WFConnection -> WFReportParams )
>>
>> [349071.573802] drbd drbd0: Starting ack_recv thread (from drbd_r_drbd0 [2660])
>>
>> [349071.688547] drbd drbd0/0 drbd0: drbd_sync_handshake:
>>
>> [349071.692323] drbd drbd0/0 drbd0: self
>> 3375B2019708F68A:0000000000000000:7D97648599B446DC:7D96648599B446DD
>> bits:1 flags:0
>>
>> [349071.699871] drbd drbd0/0 drbd0: peer
>> 7F8B15C04AF49C4D:3375B2019708F68B:3374B2019708F68B:3373B2019708F68B
>> bits:1 flags:0
>>
>> [349071.707687] drbd drbd0/0 drbd0: uuid_compare()=-1 by rule 50
>>
>> [349071.711563] drbd drbd0/0 drbd0: Becoming sync target due to disk states.
>>
>> [349071.715381] drbd drbd0/0 drbd0: peer( Unknown -> Primary ) conn(
>> WFReportParams -> WFBitMapT ) pdsk( DUnknown -> UpToDate )
>>
>> [349071.723039] drbd drbd0/0 drbd0: receive bitmap stats
>> [Bytes(packets)]: plain 0(0), RLE 23(1), total 23; compression: 100.0%
>>
>> [349071.732489] drbd drbd0/0 drbd0: send bitmap stats
>> [Bytes(packets)]: plain 0(0), RLE 23(1), total 23; compression: 100.0%
>>
>> [349071.740178] drbd drbd0/0 drbd0: conn( WFBitMapT -> WFSyncUUID )
>>
>> [349071.787113] drbd drbd0/0 drbd0: updated sync uuid
>> 3376B2019708F68A:0000000000000000:7D97648599B446DC:7D96648599B446DD
>>
>> [349071.794907] drbd drbd0/0 drbd0: helper command: /sbin/drbdadm
>> before-resync-target minor-0
>>
>> [349071.800006] drbd drbd0/0 drbd0: helper command: /sbin/drbdadm
>> before-resync-target minor-0 exit code 0 (0x0)
>>
>> [349071.807737] drbd drbd0/0 drbd0: conn( WFSyncUUID -> SyncTarget )
>>
>> [349071.811639] drbd drbd0/0 drbd0: Began resync as SyncTarget (will
>> sync 4 KB [1 bits set]).
>>
>> [349071.916117] drbd drbd0: sock was shut down by peer
>>
>> [349071.919955] drbd drbd0: peer( Primary -> Unknown ) conn(
>> SyncTarget -> BrokenPipe ) pdsk( UpToDate -> DUnknown )
>>
>> [349071.927796] drbd drbd0: short read (expected size 4096)
>>
>> [349071.931812] drbd drbd0: error receiving RSDataReply, e: -5 l: 4096!
>>
>> [349071.935864] drbd drbd0: ack_receiver terminated
>>
>> [349071.939906] drbd drbd0: Terminating drbd_a_drbd0
>>
>> [349072.088385] drbd drbd0: Connection closed
>>
>> [349072.092398] drbd drbd0: conn( BrokenPipe -> Unconnected )
>>
>> [349072.096436] drbd drbd0: receiver terminated
>>
>> [349072.100469] drbd drbd0: Restarting receiver thread
>>
>> [349072.104454] drbd drbd0: receiver (re)started
>>
>> [349072.108373] drbd drbd0: conn( Unconnected -> WFConnection )
>>
>>
>> --
>>
>>  Best Regards,
>>
>>  Serguei
> 
> 
> Thanks for the report. To be sure the issue doesn't fall through the
> cracks unnoticed, I'm adding it to regzbot, the Linux kernel regression
> tracking bot:
> 
> #regzbot ^introduced v6.4..v6.5
> #regzbot title drbd: drbd_send_block() failed
> #regzbot ignore-activity
> 
> This isn't a regression? This issue or a fix for it are already
> discussed somewhere else? It was fixed already? You want to clarify when
> the regression started to happen? Or point out I got the title or
> something else totally wrong? Then just reply and tell me -- ideally
> while also telling regzbot about it, as explained by the page listed in
> the footer of this mail.
> 
> Developers: When fixing the issue, remember to add 'Link:' tags pointing
> to the report (the parent of this mail). See page linked in footer for
> details.
> 
> Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
> --
> Everything you wanna know about Linux kernel regression tracking:
> https://linux-regtracking.leemhuis.info/about/#tldr
> That page also explains what to do if mails like this annoy you.

Hello,

thank you for the report. We were able to reproduce the issue and are
now investigating.

Based off of context we think that eeac7405c735 ("drbd: Use
sendmsg(MSG_SPLICE_PAGES) rather than sendpage()") is the culprit.
(See also the other reply by Thomas Voegtle, which confirms this.)

I'm also adding David Howells to CC, maybe he has an idea what could be
happening here.

-- 
Christoph Böhmwalder
LINBIT | Keeping the Digital World Running
DRBD HA —  Disaster Recovery — Software defined Storage
