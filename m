Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2325D7BEF08
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 01:21:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378999AbjJIXU6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 19:20:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379009AbjJIXUz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 19:20:55 -0400
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18AEEE3;
        Mon,  9 Oct 2023 16:20:52 -0700 (PDT)
Received: from [192.168.68.112] (ppp118-210-84-62.adl-adc-lon-bras32.tpg.internode.on.net [118.210.84.62])
        by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 829A220172;
        Tue, 10 Oct 2023 07:20:45 +0800 (AWST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=codeconstruct.com.au; s=2022a; t=1696893649;
        bh=JTRSLBNiIkCIhjXig6lczJ6V8eRPuYQWUv51vi2IL1I=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References;
        b=MDVFhqOUc3knrJ+wCEcPV1zgCQWdqYPDsn0RyZ2HUGmkB+QKsr3n4wDaXO6aefpog
         D0GqC5qQqgaB0MOb4DBlXebh4rVmrTrGDOcOY/m8YcTpG8GACYECyqvqU45NrhRJmJ
         7yUIBIK6lJR3HljSrGWYe6NfnE5kYLv3fxEWdkGl2xqrR4KC3g/hnj88hZqsRtwfws
         oMdhcbHiATD0rT9kI6t7FgyDZhJDoLBovkRf0LH8o0BIQaRzxYZI48hdUXU6wpzv2u
         FnOyg44+Aw/GTbRaczc3FlDSut7uxTqIusCwwQy73k0TZ2Kmk0pKsBgRcQBzghR3IV
         lGErUHnepoE9w==
Message-ID: <e303d57d5bac0bb8227e09ef6eea5867cf7866d9.camel@codeconstruct.com.au>
Subject: Re: [PATCH] crypto: aspeed-hace: Use device_get_match_data()
From:   Andrew Jeffery <andrew@codeconstruct.com.au>
To:     Rob Herring <robh@kernel.org>, Neal Liu <neal_liu@aspeedtech.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Joel Stanley <joel@jms.id.au>
Cc:     linux-aspeed@lists.ozlabs.org, linux-crypto@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Date:   Tue, 10 Oct 2023 09:50:42 +1030
In-Reply-To: <20231006213917.333702-1-robh@kernel.org>
References: <20231006213917.333702-1-robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2023-10-06 at 16:39 -0500, Rob Herring wrote:
> Use preferred device_get_match_data() instead of of_match_device() to
> get the driver match data. With this, adjust the includes to explicitly
> include the correct headers.
>=20
> Signed-off-by: Rob Herring <robh@kernel.org>

Reviewed-by: Andrew Jeffery <andrew@codeconstruct.com.au>
