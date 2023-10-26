Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B66A67D8454
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 16:15:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345194AbjJZOPt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 10:15:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345173AbjJZOPr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 10:15:47 -0400
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::221])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23ED31A2;
        Thu, 26 Oct 2023 07:15:44 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 05CBA240006;
        Thu, 26 Oct 2023 14:15:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1698329743;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zmk5IBAeXPzpC0wzTFs6TImNPJ5SP1maXmiVHllch3U=;
        b=hywaEy/v3IVahTvtOnpba06UydiCQS5ePYKCYNCAq/A9rfxYhwyzrvNeGhGd9ZtG0iS9Pu
        9ypSxxBH1+oNwUxbdU5AlNzYjt9ZMyPiA+ZaPZ50d3cFHVNkZ3sC5JCi5d8FO/xotAtkOt
        mypRazubeSbeO1igwDzFcQ0ZojOdTQdLTOHhOk5u5Fxlz21wGieO3B2GRr6bqm3zwhB7s+
        lrQxQ+6gqfFZkYQg/XHxIeaLyojw/6T5GQD7Wu25aL90CRlXYA5B9s4IuQYh1YUZAwJhyB
        YxShYCb920A1ChBDiwR/ZTBJLb+PRUFBRkdWBnUW2VOWyymcxYsiyQkXvcn8QQ==
Date:   Thu, 26 Oct 2023 16:15:42 +0200
From:   Herve Codina <herve.codina@bootlin.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Frank Rowand <frowand.list@gmail.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] of: address: Store number of bus flag cells rather
 than bool
Message-ID: <20231026161542.5e8de127@bootlin.com>
In-Reply-To: <20231026135358.3564307-2-robh@kernel.org>
References: <20231026135358.3564307-2-robh@kernel.org>
Organization: Bootlin
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: herve.codina@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 26 Oct 2023 08:53:58 -0500
Rob Herring <robh@kernel.org> wrote:

> It is more useful to know how many flags cells a bus has rather than
> whether a bus has flags or not as ultimately the number of cells is the
> information used. Replace 'has_flags' boolean with 'flag_cells' count.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
> This series applies on top of Herve's[1].

Acked-by: Herve Codina <herve.codina@bootlin.com>

Best regards,
Hervé
