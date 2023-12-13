Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32FD2810E19
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 11:15:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235193AbjLMJ7r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 04:59:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232663AbjLMJ7p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 04:59:45 -0500
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B5A583;
        Wed, 13 Dec 2023 01:59:50 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 40D6E240011;
        Wed, 13 Dec 2023 09:59:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1702461589;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nTAnT1PVzX6vcK0RfwUZyNxxQAd/jwvrT19yLQs+C4Q=;
        b=UnbSIH0Y1HCLvwbULwx2H3B1LWY96fVr8vLzUfF1/SFv9nka4g4DdQJDAkDjs38Kwm7Atk
        mp872UwH9UE7oDt7zK1SxubMXoShq3w2Pf6m+cjSwM9ao27/SiTzLqo6hudA7QuKA9970g
        WLgHOC/5FRwEvcpYnSuJl2adqREKc1qWIfhSrEH3UKLlUyZNJqhX/qETogIopr1bq4EM8o
        paXnwt/VrPgrAuR6/J/miZPdF5CQfKhOi4JbzoXemoCK4cqva1TYYlUTSbwap+ZOdKVdxj
        aaB00qqbkN0rmExstwn1PdamLsNOfLzeb1N//3GTUIKOvxgUPuKgyzf4C/bdQg==
Date:   Wed, 13 Dec 2023 10:59:48 +0100
From:   Kamel Bouhara <kamel.bouhara@bootlin.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Conor Dooley <conor@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Henrik Rydberg <rydberg@bitmath.org>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Marco Felsch <m.felsch@pengutronix.de>,
        Jeff LaBundy <jeff@labundy.com>,
        catalin.popescu@leica-geosystems.com,
        mark.satterthwaite@touchnetix.com, bartp@baasheep.co.uk,
        hannah.rossiter@touchnetix.com,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        bsp-development.geo@leica-geosystems.com
Subject: Re: [PATCH v5 2/3] dt-bindings: input: Add TouchNetix axiom
 touchscreen
Message-ID: <20231213095948.GD2340704@kb-xps>
References: <20231211121430.1689139-1-kamel.bouhara@bootlin.com>
 <20231211121430.1689139-3-kamel.bouhara@bootlin.com>
 <20231212-rework-bounce-f4d9d12362a4@spud>
 <ce238248-6bac-41df-94ba-b494c5c09631@linaro.org>
 <20231213082256.GB2340704@kb-xps>
 <656f2245-ff76-48cf-9a1f-05259765c622@linaro.org>
 <20231213091417.GC2340704@kb-xps>
 <de1ee415-31b0-45fd-b376-f7aa83b64c64@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <de1ee415-31b0-45fd-b376-f7aa83b64c64@linaro.org>
X-GND-Sasl: kamel.bouhara@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le Wed, Dec 13, 2023 at 10:15:35AM +0100, Krzysztof Kozlowski a écrit :
> On 13/12/2023 10:14, Kamel Bouhara wrote:
> > Le Wed, Dec 13, 2023 at 09:46:03AM +0100, Krzysztof Kozlowski a écrit :
> >> On 13/12/2023 09:22, Kamel Bouhara wrote:
> >>>> It still brings the type of some fields or the constraints. However need
> >>>> of specifying "poll-interval" already points to missing
> >>>> unevaluatedProperties.
> >>>
> >>> Ok, this wasn't clear for me wether or not I should pick
> >>> unevaluatedProperties
> >>
> >> Yes
> >>
> >>> as I still reference "poll-interval" from the
> >>> input.yaml schema ?
> >>
> >> You should drop it from your binding.
> >
> > The driver use it could you explain why I should drop it ?
>
> Because it comes from input.yaml and you did not add any constraints, so
> poll-interval here is redundant.
>

Ok clear, thanks !

Regards,
--
Kamel Bouhara, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com
