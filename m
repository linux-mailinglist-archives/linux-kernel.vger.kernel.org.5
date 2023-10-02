Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F88F7B5334
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 14:29:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237052AbjJBM3E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 08:29:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237010AbjJBM3C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 08:29:02 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA463AD;
        Mon,  2 Oct 2023 05:28:52 -0700 (PDT)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1qnI2a-0001s7-7U; Mon, 02 Oct 2023 14:28:48 +0200
Message-ID: <541ac45b-8de7-4fa2-85ee-456d34e60aa9@leemhuis.info>
Date:   Mon, 2 Oct 2023 14:28:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] ASoC: amd: yc: Fix non-functional mic on Lenovo 82YM
Content-Language: en-US, de-DE
To:     Mark Brown <broonie@kernel.org>,
        Linux regressions mailing list <regressions@lists.linux.dev>
Cc:     Sven Frotscher <sven.frotscher@gmail.com>,
        mario.limonciello@amd.com, git@augustwikerfors.se,
        alsa-devel@alsa-project.org, lgirdwood@gmail.com,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Takashi Iwai <tiwai@suse.com>
References: <20230927223758.18870-1-sven.frotscher@gmail.com>
 <46560887-0b6e-42ac-96c3-b4dbc1d7cb61@leemhuis.info>
 <4fa7d39d-dc34-4550-97fa-2b089f364cca@sirena.org.uk>
From:   "Linux regression tracking (Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <4fa7d39d-dc34-4550-97fa-2b089f364cca@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1696249732;b7b8f42f;
X-HE-SMSGID: 1qnI2a-0001s7-7U
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02.10.23 13:52, Mark Brown wrote:
> On Mon, Oct 02, 2023 at 11:32:48AM +0200, Linux regression tracking (Thorsten Leemhuis) wrote:
> 
>> Makes me wonder: How many more such quirk entries will be needed? Will
>> we have all machines listed soon, or do we expect that future Lenovo
>> hardware will need entries as well? If it's the latter: are quirks
>> really the right solution here, or do they just hide some bug or then
>> need for code that automatically handles things?
> 
> x86 firmware descriptions are terrible, it's just an endless procession
> of quirks.  The model for ACPI is not to describe key information in the
> kernel and instead on Windows load device specific information from
> separately supplied tables.  On Linux that translates into these endless
> quirks, on Windows it's platform specific drivers for otherwise generic
> audio hardware.

I know all of that, but from the many recent regression reports and
patches it seems quirks were not needed for a bunch of Lenovo machines
before c008323fe361bd ("ASoC: amd: yc: Fix a non-functional mic on
Lenovo 82SJ") [v6.5]. That made me wonder if that commit really did the
right thing or if there is a underlying bug somewhere that the newly
added quirks hide, as I had a few such situations during the past few
months. If you or others the experts in this area say that this is not
the case here then I'm totally fine with that, it was just a question.

Ciao, Thorsten
