Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91A877C70A2
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 16:47:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378924AbjJLOrE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 10:47:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378887AbjJLOrA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 10:47:00 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 463D4B8
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 07:46:57 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0385EC433C7;
        Thu, 12 Oct 2023 14:46:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697122016;
        bh=WYk8Vw1pWoRdShAXmpY6B+PhCJi+fjgJkBB4Nnw4F/0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=A2UIuOXGvcUyOe18uadv3OKJBKlOJd88IIqUXS5j+7tgaXUqBzENh6ZDfUHFIgy3F
         Va7kGtUTfOVkF4021igWT2kzet6PsLoMNFUi3wHHk29qsQ+4If5Ns30rZi+sO7+w3c
         x8RzyfqLdnPQ4cuu7oFRs4Qp71juywTPfWoLPWsN3nw/InGbllkmnqe64V7Pc0CY3V
         H3L86P2qxFyRUJGbmYhQKAR65yJtfc1GyiahBl28gIp+8tkg5SxBuAIsOf5IMyCdCR
         mbayMpRkjvx7gQQW1sBxBfOXdRvpyFPTTkYKY/54wpzXHiDwf/t0SG6POT/kUuhu49
         S8B/gpoJ4841A==
Received: (nullmailer pid 554377 invoked by uid 1000);
        Thu, 12 Oct 2023 14:46:54 -0000
Date:   Thu, 12 Oct 2023 09:46:54 -0500
From:   Rob Herring <robh@kernel.org>
To:     Tanmay Shah <tanmay.shah@amd.com>
Cc:     conor+dt@kernel.org, shubhrajyoti.datta@amd.com,
        linux-arm-kernel@lists.infradead.org,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        jassisinghbrar@gmail.com, michal.simek@amd.com
Subject: Re: [PATCH v2 1/2] dt-bindings: zynqmp: add destination mailbox
 compatible
Message-ID: <169712201405.554322.6115611735958707225.robh@kernel.org>
References: <20231007042702.178028-1-tanmay.shah@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231007042702.178028-1-tanmay.shah@amd.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 06 Oct 2023 21:27:01 -0700, Tanmay Shah wrote:
> Current dt-bindings does not contain compatible property
> for child mailbox node. Child mailbox nodes are used
> to represent destination (remote) IPI agents. The compatible
> property for all destination mailboxes must be required to
> identify the node.
> 
> This addition of new required property does not break ABI
> as current driver does not use this compatible property
> but, new features in driver should use this property.
> 
> Signed-off-by: Tanmay Shah <tanmay.shah@amd.com>
> ---
> 
> Changes in v2:
>   - Fix commit message about breaking ABI
> 
>  .../bindings/mailbox/xlnx,zynqmp-ipi-mailbox.yaml           | 6 ++++++
>  1 file changed, 6 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>

