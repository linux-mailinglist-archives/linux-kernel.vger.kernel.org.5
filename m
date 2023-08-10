Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2771E77716D
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 09:38:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232611AbjHJHiG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 03:38:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjHJHiF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 03:38:05 -0400
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3497E10E9
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 00:38:04 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 5E591C0002;
        Thu, 10 Aug 2023 07:38:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1691653083;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Lq3q3lkKBxWurRNhXxTmv9g9e19s6OWIb+pFHyepukk=;
        b=jyDUOHZ3ynN6/1Y6r3YrlTUAVU6AaH7j9Weom92K0Ghi5wuOtDHufy7Rofr46pNoebTr/u
        Q5nmELPwMOJSBAnzDMh9KGGw3H2sbnfFSHYGQZLlvTsjH5DBpiwxaK+k5i4E8Yb5CohqeV
        Qjbt5pS4PjFNDN6TY3qtOqHcZAYDfUiiWSw1lhsw7p2AI8s/t6I8eQXh+it2ZnuM51ILGs
        Sxr3cm/Dk/Ssyf61m+hNGw1o6yBxw6sYJLpxN4kVN9X7z8mfD2dqoNBDlhfh4G0Oejru4F
        ekaBYu9jcBcBGoDklt2XrJOamG9GGyOCyn+KWxWVb8XEnsGVIw7W7bpLmAJfJg==
Date:   Thu, 10 Aug 2023 09:38:03 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org,
        Billy Tsai <billy_tsai@aspeedtech.com>
Subject: Re: [PATCH] i3c/master: cmd_v1: Fix the exit criteria for the daa
 procedure
Message-ID: <169165306480.966832.11791541519030436327.b4-ty@bootlin.com>
References: <20230802100909.2568215-1-billy_tsai@aspeedtech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230802100909.2568215-1-billy_tsai@aspeedtech.com>
X-GND-Sasl: alexandre.belloni@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 02 Aug 2023 18:09:09 +0800, Billy Tsai wrote:
> The exit criteria for the DAA should check if the data length is equal to
> 1, instead of checking if the response status is equal to 1.
> 
> 

Applied, thanks!

[1/1] i3c/master: cmd_v1: Fix the exit criteria for the daa procedure
      commit: cbf871e6d8ce23dd4d458d8b7ab9d4a267e7bc03

Best regards,

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
