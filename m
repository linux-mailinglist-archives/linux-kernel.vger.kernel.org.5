Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4E0179BE75
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 02:17:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235477AbjIKUtU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 16:49:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241098AbjIKPBy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 11:01:54 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C8A9125;
        Mon, 11 Sep 2023 08:01:49 -0700 (PDT)
Date:   Mon, 11 Sep 2023 17:01:44 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1694444507;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hmtb7inBfN9yXnfv6q7DROjKL4bqbMgCux9ZhSeiIQs=;
        b=DRVy5+d1O/qYZ/B9tsOCtlyHj9HMbQFTR0+QYAYk8xLu+TM98PycdU2p2De7DupP4HjoGc
        hqWLZHnWDatKHG77b/Ald3gip4AR5lTiMgA17mbPXe0NSVZWsQYkt8/n/GeLmJo8uHLXcI
        IQkxDcwn4AYO/OlU8ya/cq9BQZ5y3deQefiIVRnnw+eW+e8SXugVQVNPatYs0mCGdAspqA
        F7j1qUT3RucjjRBlumVudUtjTwXYnUnfx9SpkwKHyds/DhS88dhbyOLTI5Iln7Hf3TMnwp
        8y0jrJOGpm2jXzShu0elZYtUX4JR065tMSVUWJsyO8Sp1AExlf6mia7WW6Ra+A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1694444507;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hmtb7inBfN9yXnfv6q7DROjKL4bqbMgCux9ZhSeiIQs=;
        b=Z50ZZcZC0GsPfc1bExnGheRaWqEM9Hj5agGmTmwuv8gxhOuOkmYpSo5q2nOzpRFBDgMOkG
        tLptfM7GimhI0zCg==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Lukasz Majewski <lukma@denx.de>
Cc:     Tristram.Ha@microchip.com, Eric Dumazet <edumazet@google.com>,
        davem@davemloft.net, Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Kristian Overskeid <koverskeid@gmail.com>,
        Matthieu Baerts <matthieu.baerts@tessares.net>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andreas Oetken <ennoerlangen@gmail.com>
Subject: Re: [PATCH] net: hsr : Provide fix for HSRv1 supervisor frames
 decoding
Message-ID: <20230911150144.cG1ZHTCC@linutronix.de>
References: <20230825153111.228768-1-lukma@denx.de>
 <20230905080614.ImjTS6iw@linutronix.de>
 <20230905115512.3ac6649c@wsk>
 <20230911165708.0bc32e3c@wsk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20230911165708.0bc32e3c@wsk>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-09-11 16:57:08 [+0200], Lukasz Majewski wrote:
> Hi Sebastian,
Hi,

>=20
> Have you had time to review this patch?

got distracted a few times. I need a quiet moment=E2=80=A6 Will do this wee=
k=E2=80=A6

> Your comments are more than welcome.

Sebastian
