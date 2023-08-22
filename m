Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 070DE784C44
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 23:52:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231444AbjHVVwh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 17:52:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231445AbjHVVwg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 17:52:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0365CE;
        Tue, 22 Aug 2023 14:52:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 783D86387F;
        Tue, 22 Aug 2023 21:52:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D27CBC433C7;
        Tue, 22 Aug 2023 21:52:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692741153;
        bh=ic+DamMPx+g7vMiX+D3avlGdsv0Mk/FVcDsZjosNUmI=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=LRqo6NM4WO4NDIKNviRmbdygO47qofghEEURXEWzW56WQR9HcQ+B3RGsQvzywkTeC
         LwWckJY/OdOHwGjoCeqpgPyQUeADWsQlrVrHEfQ8dUukOSErzHbZDcFYfJeWdO0zsr
         bNoWH32CSsrCpcmEf/NKa1GCFsLPnYJAFFFxxWTx7xMGv2/1IK43EnMRdUNVQqp9ve
         rj5xtdkVoIuydRhiXi4ADIcYLPvYKPn6aQPkyioK6O+MxpefaXcoJZ10iq5SVfCe2N
         dpVumlzrkcbNJOXOLbDmBl/rVIJjvIeiwvXOGiXFCEMwr4gg7pmjNJAZ8tsBj3L/aE
         hjKfE4aItAIwQ==
Message-ID: <04e9e7204970a75d43ddecf4cb3462e6.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20230705065313.67043-11-frank.li@vivo.com>
References: <20230705065313.67043-1-frank.li@vivo.com> <20230705065313.67043-11-frank.li@vivo.com>
Subject: Re: [PATCH 11/13] clk: socfpga: agilex: Convert to devm_platform_ioremap_resource()
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Yangtao Li <frank.li@vivo.com>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
To:     Dinh Nguyen <dinguyen@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Yangtao Li <frank.li@vivo.com>
Date:   Tue, 22 Aug 2023 14:52:31 -0700
User-Agent: alot/0.10
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Yangtao Li (2023-07-04 23:53:11)
> Use devm_platform_ioremap_resource() to simplify code.
>=20
> Signed-off-by: Yangtao Li <frank.li@vivo.com>
> ---

Applied to clk-next
