Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 816757BFE88
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 15:54:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232785AbjJJNym (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 09:54:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232508AbjJJNye (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 09:54:34 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA678D3
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 06:54:30 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4631CC433C9;
        Tue, 10 Oct 2023 13:54:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696946070;
        bh=cpr5M03mDBi9QYzoamwhalraoyUpzQ9rzlWPtaN31MI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kqie0jq2vyoogMWRvJAmCpy0XZrj9Id0YaSWZ1cVu9uj2jqa9HjL5/o+RZKnFs+J+
         n1OrbDDi5PUiu3gzfu0qXLRxnf8Q6Zu/qRHVdLk3NEv9O+tgrJke+c8x0iCyKdoQ9i
         i+P13VS1iV9RAAmduOe/MrmxozQOzzchuipQvY7uJo8HjXk0qdnc4gLPMFhKLglKin
         +FPWB30sL+qxyBzwOs8B4qD4dGeKLRBz+QPlL67lHBO8VGroXjMEg48a+YDxyYP+T7
         B1NV5D5a94pZGL2142t6I0ZRLKSJBAWXgAfzTXylQizxTdKH3/L6KsE44EFYcQzrRF
         jHbGiZnC6rPrw==
Received: (nullmailer pid 661704 invoked by uid 1000);
        Tue, 10 Oct 2023 13:54:28 -0000
Date:   Tue, 10 Oct 2023 08:54:28 -0500
From:   Rob Herring <robh@kernel.org>
To:     Simon Glass <sjg@chromium.org>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        linux-mtd@lists.infradead.org, Nick Terrell <terrelln@fb.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Richard Weinberger <richard@nod.at>,
        devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        U-Boot Mailing List <u-boot@lists.denx.de>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
        Tom Rini <trini@konsulko.com>,
        Conor Dooley <conor+dt@kernel.org>
Subject: Re: [PATCH v4] dt-bindings: mtd: fixed-partitions: Add compression
 property
Message-ID: <169694606700.661639.10236902968461331107.robh@kernel.org>
References: <20230927180545.3522628-1-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230927180545.3522628-1-sjg@chromium.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 27 Sep 2023 12:05:43 -0600, Simon Glass wrote:
> Sometimes the contents of a partition are compressed. Add a property to
> express this and define the algorithm used.
> 
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
> 
> Changes in v4:
> - Add an example
> 
> Changes in v3:
> - Just add a compression property for now
> 
> Changes in v2:
> - Use "binman" for compatible instead of "u-boot,binman"
> - Significantly rework the patch
> - Use make dt_binding_check DT_SCHEMA_FILES=Documentation/../partitions
> 
>  .../mtd/partitions/fixed-partitions.yaml      | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>

