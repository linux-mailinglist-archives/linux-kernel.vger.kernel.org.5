Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDFDB7F6141
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 15:18:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345734AbjKWOSE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 09:18:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345730AbjKWOSC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 09:18:02 -0500
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 820DFB9
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 06:18:07 -0800 (PST)
Received: from [10.0.3.168] (unknown [93.240.169.83])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id 38C2A61E5FE03;
        Thu, 23 Nov 2023 15:17:34 +0100 (CET)
Message-ID: <ac27ba40-0f44-4503-a167-25e4f1211900@molgen.mpg.de>
Date:   Thu, 23 Nov 2023 15:17:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Powered off Philips TV sends corrupt EDID causing flickering
To:     Jani Nikula <jani.nikula@linux.intel.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        dri-devel@lists.freedesktop.org
References: <c9e3a8f1-d053-4203-a364-0d0703fafd19@molgen.mpg.de>
 <87leaqm5sl.fsf@intel.com>
Content-Language: en-US
From:   Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <87leaqm5sl.fsf@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Jani,


Thank you for your reply.

Am 22.11.23 um 11:38 schrieb Jani Nikula:
> On Tue, 21 Nov 2023, Paul Menzel wrote:

>> Connecting a USB Type-C port replicator [1] to the only USB Type-C port
>> of the Dell XPS 13 9360 with Debian sid/unstable and Debian’s Linux
>> kernel 6.10.5, and then connecting a Philips 40PFL5206H/12 TV device,
>> that is powered off or in standby, to the HDMI port, Linux logs:

[…]

> Depending on how the port replicator works, this may not come from the
> TV at all.
> 
> And all of this probably depends on GPU and driver, which are not
> mentioned.

Sorry for just mentioning the laptop model. It uses the device below:

     00:02.0 VGA compatible controller [0300]: Intel Corporation HD 
Graphics 620 [8086:5916] (rev 02) (prog-if 00 [VGA controller])

> If it's i915, please see [1] on how to file a bug.

Thank you for taking the time to tell me the proper forum. I created the 
two issues below:

1.  EDID has corrupt header [2]
2.  No image on Philips TV when turning on while connected over 
HDMI/USB-C port replicator (`[drm] *ERROR* Link Training Unsuccessful`) [3]


Kind regards,

Paul


> [1] https://drm.pages.freedesktop.org/intel-docs/how-to-file-i915-bugs.html
[2]: https://gitlab.freedesktop.org/drm/intel/-/issues/9705
[3]: https://gitlab.freedesktop.org/drm/intel/-/issues/9707
