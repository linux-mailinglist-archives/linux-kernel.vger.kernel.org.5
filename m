Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82323784C40
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 23:51:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231430AbjHVVvu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 17:51:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229663AbjHVVvt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 17:51:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93582CD1;
        Tue, 22 Aug 2023 14:51:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2EC5163B5B;
        Tue, 22 Aug 2023 21:51:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EC4CC433C9;
        Tue, 22 Aug 2023 21:51:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692741106;
        bh=eQ4GnBYPYGvZuFK7LlR94iShadqqlY+WPtlxqG/3ofs=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=uEAZ1i0OjlWXQBDLB6CDcpCEK+dfKB1eGZZVHSIRPz9suG8zoDKX7hye+3AQcyOSS
         7LnU0heEAChM4qO40Pd0ATYCEBgIbHhsPplg3cxtr8riWY7xxxyDuW1In05WiXcIbH
         X/Ks6FSeluuarjnLriEfvrh7+qxqnXAGyF8+ASZuov9FlfNjPZ9GnlgbSFWvq6kvgx
         jMYm0jyS9cDChInyLkz/8V2AQ9kstS48TPj6m41wchkHsYPSYU4/aWAfkmnxfnJqPA
         9eWU8BbJFDn3Im9suPNqTcQ22pQ3l9jRu2N6lm4vFBLpIqgVDwhg/AzS8KwceuZh6b
         qYTOx/T/7OXUA==
Message-ID: <3ec1ef65c40a4a81efe923cb6da7c52f.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20230705065313.67043-13-frank.li@vivo.com>
References: <20230705065313.67043-1-frank.li@vivo.com> <20230705065313.67043-13-frank.li@vivo.com>
Subject: Re: [PATCH 13/13] clk: mvebu: Convert to devm_platform_ioremap_resource()
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Yangtao Li <frank.li@vivo.com>,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
To:     Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Yangtao Li <frank.li@vivo.com>
Date:   Tue, 22 Aug 2023 14:51:44 -0700
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

Quoting Yangtao Li (2023-07-04 23:53:13)
> Use devm_platform_ioremap_resource() to simplify code.
>=20
> Signed-off-by: Yangtao Li <frank.li@vivo.com>
> ---

Applied to clk-next
