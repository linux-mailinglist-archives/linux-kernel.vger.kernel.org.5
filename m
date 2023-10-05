Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2BEC7BA55D
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 18:16:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240554AbjJEQQB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 12:16:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240576AbjJEQNI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 12:13:08 -0400
Received: from thorn.bewilderbeest.net (thorn.bewilderbeest.net [IPv6:2605:2700:0:5::4713:9cab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6BF224868;
        Thu,  5 Oct 2023 04:17:15 -0700 (PDT)
Received: from hatter.bewilderbeest.net (unknown [IPv6:2602:61:7e5d:5300::2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: zev)
        by thorn.bewilderbeest.net (Postfix) with ESMTPSA id 5F022AE8;
        Thu,  5 Oct 2023 04:17:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bewilderbeest.net;
        s=thorn; t=1696504632;
        bh=+QvPDf6laDoyUA3qVW9l7YF9DF+U8wakjINq8xl+7A8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=THrE/kJt+qUUemMdOCjsTm0Ih9z6M8yAaBTeXhcI31NxW11TrRFJBDG+4EwpO3ZYs
         FY1pO8SUDuTt5EpVqWJj/xazDuWM7NaKB6c+TyivvAzLcTvaeLYWDMyJT6H/by/5Xi
         lC7GaMsuiGlUQhR43qYV4YncCOJbFtYvo9bpsbNQ=
Date:   Thu, 5 Oct 2023 04:17:10 -0700
From:   Zev Weiss <zev@bewilderbeest.net>
To:     Naresh Solanki <naresh.solanki@9elements.com>
Cc:     Rob Herring <robh@kernel.org>, broonie@kernel.org,
        Liam Girdwood <lgirdwood@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 1/3] dt-bindings: regulator: regulator-output: Multiple
 supplies
Message-ID: <c486c7dd-add2-45db-8fbc-94391f79a374@hatter.bewilderbeest.net>
References: <20231004120529.1155700-1-naresh.solanki@9elements.com>
 <20231004151433.GA3145438-robh@kernel.org>
 <CABqG17in=LKwsDoPRmN5NMNiZ3wU=bbWiyPdunpwph7hgPSxEw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CABqG17in=LKwsDoPRmN5NMNiZ3wU=bbWiyPdunpwph7hgPSxEw@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 05, 2023 at 12:46:31AM PDT, Naresh Solanki wrote:
>Hi Rob,
>
>
>On Wed, 4 Oct 2023 at 20:44, Rob Herring <robh@kernel.org> wrote:
>>
>> On Wed, Oct 04, 2023 at 02:05:26PM +0200, Naresh Solanki wrote:
>> > Add support for multiple supplies.
>>
>> Why?
>1. Driver is already capable of that using platform data. Hence added
>support to read DT property & initialize the same for multiple
>supplies instead of being limited to one.
>2. This is particularly useful in cases wherein 2 or more regulators
>are coupled together, for example in a PCIe connector having 3.3V &
>12V.
>

Hmm -- apologies if I pointed you in the wrong direction here on the 
last revision (or should have considered this earlier), but is there a 
particular need for this arrangement to be described by a single 
regulator-output DT node instead of just having one node per supply?  If 
they're independently-controlled voltage outputs, treating them as two 
separate things instead of a single ganged one seems like it might be 
more appropriate anyway...


Zev

