Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1062F7DDDDB
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 09:45:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232357AbjKAIpZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 04:45:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231420AbjKAIpX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 04:45:23 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [IPv6:2a01:4f8:c010:41de::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67CAEA2;
        Wed,  1 Nov 2023 01:45:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=t-8ch.de; s=mail;
        t=1698828315; bh=dUn69NpLHm95YlSQflbcp4YFtXVEb5UF3XD5Lg1d5gg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=O/NmY7tTzxPyPRa6lTNocgFIqOJjvGDfR88RyqlmXkdEZ7KnUY4FVhnBV3jXO8kEI
         M2K26fSQ1MFk/XD4lCApNP3GBO+iQMfsLYdH+097QrWsdV0BaKT/kvH3dglzSYgE7e
         +x288rUcOvxWX4XNS3TIhOxl1Pwtol6ggbdpS4rA=
Date:   Wed, 1 Nov 2023 09:45:14 +0100
From:   Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas@t-8ch.de>
To:     Anshul Dalal <anshulusr@gmail.com>
Cc:     linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jeff LaBundy <jeff@labundy.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 2/2] input: joystick: driver for Adafruit Seesaw
 Gamepad
Message-ID: <2241e06f-ef90-4299-97cd-cfb8fd569065@t-8ch.de>
References: <20231027051819.81333-1-anshulusr@gmail.com>
 <20231027051819.81333-2-anshulusr@gmail.com>
 <d1dd2142-546f-42b7-8966-ab75fd4f8817@t-8ch.de>
 <efea5ae2-7e41-4b78-a283-1f907be560b0@gmail.com>
 <9c9f6171-f879-46f5-81d2-6764257a49eb@t-8ch.de>
 <152d15c4-10bb-45fe-9b9c-b323535a921f@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <152d15c4-10bb-45fe-9b9c-b323535a921f@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Anshul,

On 2023-11-01 09:50:36+0530, Anshul Dalal wrote:
> On 10/31/23 07:53, Thomas Weißschuh wrote:
> > Oct 31, 2023 03:10:50 Anshul Dalal <anshulusr@gmail.com>:
> >> Thanks for the review! The requested changes will be addressed in the
> >> next patch version though I had a few comments below:
> >>
> >> On 10/27/23 11:44, Thomas Weißschuh wrote:
> >>> Hi Anshul,
> >>>
> >>> thanks for the reworks!
> >>>
> >>> Some more comments inline.
> >>>
> >>> On 2023-10-27 10:48:11+0530, Anshul Dalal wrote:
> > 
> > [..]
> > 
> >>>> +struct seesaw_button_description {
> >>>> +   unsigned int code;
> >>>> +   unsigned int bit;
> >>>> +};
> >>>> +
> >>>> +static const struct seesaw_button_description seesaw_buttons[] = {
> >>>> +   {
> >>>> +       .code = BTN_EAST,
> >>>> +       .bit = SEESAW_BUTTON_A,
> >>>> +   },
> >>>> +   {
> >>>> +       .code = BTN_SOUTH,
> >>>> +       .bit = SEESAW_BUTTON_B,
> >>>> +   },
> >>>> +   {
> >>>> +       .code = BTN_NORTH,
> >>>> +       .bit = SEESAW_BUTTON_X,
> >>>> +   },
> >>>> +   {
> >>>> +       .code = BTN_WEST,
> >>>> +       .bit = SEESAW_BUTTON_Y,
> >>>> +   },
> >>>> +   {
> >>>> +       .code = BTN_START,
> >>>> +       .bit = SEESAW_BUTTON_START,
> >>>> +   },
> >>>> +   {
> >>>> +       .code = BTN_SELECT,
> >>>> +       .bit = SEESAW_BUTTON_SELECT,
> >>>> +   },
> >>>> +};
> >>>
> >>> This looks very much like a sparse keymap which can be implemented with
> >>> the helpers from <linux/input/sparse-keymap.h>.
> >>>
> >>
> >> When going through the API provided by sparse-keymap, I could only see
> >> the use for sparse_keymap_report_entry here. Which leads to the
> >> following refactored code:
> >>
> >> static const struct key_entry seesaw_buttons_new[] = {
> >>     {KE_KEY, SEESAW_BUTTON_A, {BTN_SOUTH}},
> >>     {KE_KEY, SEESAW_BUTTON_B, {BTN_EAST}},
> > 
> > No braces I think.
> > 
> 
> Since the last field in key_entry is a union, the braces seem to be
> required.

Indeed.

To make the union more visible explicit this could be done:

{ KE_KEY, SEESAW_BUTTON_A, .keycode = BTN_SOUTH }

> 
> >>     ...
> >> };
> >>
> >> for (i = 0; i < ARRAY_SIZE(seesaw_buttons_new); i++) {
> >>     sparse_keymap_report_entry(input, &seesaw_buttons_new[i],
> >>         data.button_state & BIT(seesaw_buttons_new[i].code),
> >>         false);
> >> }
> >>
> >> I don't think this significantly improves the code unless you had some
> >> other way to use the API in mind.
> > 
> > I thought about sparse_keymap_setup() and sparse_keymap_report_event().
> > 
> > It does not significantly change the code but would be a standard API.
> > 
> 
> Thanks for pointing me in the right direction, do you think the
> following implementation of the API is acceptable for the driver. Since
> I couldn't find a driver for any similar device using the API in this
> manner.
> 
> inside seesaw_probe():
> 
> err = sparse_keymap_setup(seesaw->input_dev, seesaw_buttons_new, NULL);
> if (err) {
> 	dev_err(&client->dev,
> 		"failed to set up input device keymap: %d\n", err);
> 	return err;
> }

Yes, and it replaces the calls to input_set_capability().

> inside seesaw_poll():
> 
> for (i = 0; i < ARRAY_SIZE(seesaw_buttons_new); i++) {
> 	if (!sparse_keymap_report_event(
> 		input, seesaw_buttons_new[i].code,
> 		data.button_state & BIT(seesaw_buttons_new[i].code),
> 		false)) {
> 		dev_err_ratelimited(
> 			&input->dev,
> 			"failed to report event for keycode: %d",
> 			seesaw_buttons_new[i].keycode);
> 		return;
> 	}
> }

for_each_set_bit(i, (long *)&SEESAW_BUTTON_MASK, BITS_PER_TYPE(SEESAW_BUTTON_MASK))
	sparse_keymap_report_event(input, BIT(i), data.button_state & BIT(i), false);

The sparse keymap takes care of the translation.


Notes:

SEESAW_BUTTON_MASK is now an actual variable instead of a macro.
It should be 'static const' in that case.

When using the sparse keymap APIs the driver also needs to depend on
INPUT_SPARSEKMAP.


Thomas
