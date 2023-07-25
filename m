Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E03BD760F93
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 11:41:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233290AbjGYJlx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 05:41:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233179AbjGYJls (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 05:41:48 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE471CD;
        Tue, 25 Jul 2023 02:41:36 -0700 (PDT)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1qOEXo-0005QE-OR; Tue, 25 Jul 2023 11:41:28 +0200
Message-ID: <b4a0011e-95fc-dc3c-8201-cc6f64bd7671@leemhuis.info>
Date:   Tue, 25 Jul 2023 11:41:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH RESEND 2/2] Bluetooth: fix use-bdaddr-property quirk
Content-Language: en-US, de-DE
To:     Amit Pundir <amit.pundir@linaro.org>,
        Johan Hovold <johan@kernel.org>
Cc:     Johan Hovold <johan+linaro@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linux regressions mailing list <regressions@lists.linux.dev>
References: <20230531090424.3187-1-johan+linaro@kernel.org>
 <20230531090424.3187-3-johan+linaro@kernel.org>
 <CAMi1Hd3fe=wk02WG8J7K5Ud1GcWkuKKKrxFjkNguxDkzNz2WVQ@mail.gmail.com>
 <ZKfyH4jRGlVlcLeY@hovoldconsulting.com>
 <CAMi1Hd2CGQKbMPm6GXfSHgrdHsyngBQ_DBseF08=oEvGdizVcw@mail.gmail.com>
 <ZKvvN53dM5vbAFGi@hovoldconsulting.com>
 <CAMi1Hd3-iiNYfSyrvXpsjEFQ+_PzR_WJPoDEbcnAvH+Q1O_Pmw@mail.gmail.com>
From:   "Linux regression tracking (Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <CAMi1Hd3-iiNYfSyrvXpsjEFQ+_PzR_WJPoDEbcnAvH+Q1O_Pmw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1690278096;c1734ebf;
X-HE-SMSGID: 1qOEXo-0005QE-OR
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10.07.23 14:22, Amit Pundir wrote:
> On Mon, 10 Jul 2023 at 17:14, Johan Hovold <johan@kernel.org> wrote:
>> On Fri, Jul 07, 2023 at 07:12:35PM +0530, Amit Pundir wrote:
>>> On Fri, 7 Jul 2023 at 16:37, Johan Hovold <johan@kernel.org> wrote:
>>>> Are there any error messages in the log when running with this patch?
>>> I don't see any relevant error message in dmesg. I'll check if I can
>>> find a command line BT debug tool which I can use on AOSP for
>>> debugging. There used to be a few hci command line tools, when I
>>> looked into it a few years ago. Not sure if they are still around and
>>> useful.
>> Yeah, I'm not sure how you set the device address with the Android
>> stack, but there must be some way as there are other bluetooth
>> controllers out there which similarly need a valid address before they
>> can be used.
> I'll look if I can reuse/simplify "btmgmt public-addr" command on
> Android or find an equivalent tool to do that.

Please correct me if I'm wrong: the avove to me sounds like you are
happy with this approach, even if this is kind of a regression; but
likely one that is rare and thus not worth making a fuzz about. In that
case I'll remove it from the regression tracking:

#regzbot resolve: minor issue, workaround found
#regzbot ignore-activity

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
If I did something stupid, please tell me, as explained on that page.
