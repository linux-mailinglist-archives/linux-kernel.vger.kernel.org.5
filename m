Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C32947D5D88
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 23:55:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344419AbjJXVzQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 17:55:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230458AbjJXVzP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 17:55:15 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CFA7E8;
        Tue, 24 Oct 2023 14:55:13 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F67EC433C8;
        Tue, 24 Oct 2023 21:55:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698184513;
        bh=P7/4e1Dwgwt6xkr0kjlejhcedqORVdLF8phzFc0FC4c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=A45HtPK8zMeczF81V+jdlq9O1vbVl7KDiDIZ6k3hJb6Hn/TOoVdfNRpjxgDkrVyzC
         OkcBER41dgrC2iegEaAOeAU4tlepjR/0azIex+fIS/hpEVkrfuZbDq43sEHofbbpIx
         eWORneNvBI5STQMUfxZBO8PWWBP5HHTPZo6o97+K58XKJdDNHJoY4NKArS/7Q6bSSl
         DiEhtFh3GKjQVpHCNbOokwIA8KXeh5fnl+IlK20RJgY6Z/KSS9ctwztNloUguMiTNE
         qX78/cTki23SQzoL2NY6ZDT8ZEZN7OIJjijwH1/6CbbuDITYv/FFywxKW3FCi3A9kx
         DGkSv66oBd7mg==
Date:   Tue, 24 Oct 2023 23:55:09 +0200
From:   Andi Shyti <andi.shyti@kernel.org>
To:     =?utf-8?B?QW5kcsOp?= Draszik <andre.draszik@linaro.org>
Cc:     linux-kernel@vger.kernel.org, krzysztof.kozlowski@linaro.org,
        alim.akhtar@samsung.com, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH v2] tty: serial: samsung_tty: remove dead code
Message-ID: <20231024215509.ak4jbbahw2vsahs6@zenone.zhora.eu>
References: <20231019100901.4026680-1-andre.draszik@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231019100901.4026680-1-andre.draszik@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andre,

On Thu, Oct 19, 2023 at 11:09:01AM +0100, André Draszik wrote:
> When support for various old platforms was removed in commit
> 1ea35b355722 ("ARM: s3c: remove s3c24xx specific hacks"),
> s3c24xx_serial_ops also became unused here because nothing sets port
> type TYPE_S3C24XX anymore.
> 
> Remove s3c24xx_serial_ops and all the code that's unreachable now.
> 
> Fixes: 1ea35b355722 ("ARM: s3c: remove s3c24xx specific hacks")

is this really a fix? Or is it a cleanup?

Andi

> Signed-off-by: André Draszik <andre.draszik@linaro.org>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
