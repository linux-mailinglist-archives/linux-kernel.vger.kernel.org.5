Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB9FF773FD8
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 18:54:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233710AbjHHQyS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 12:54:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233641AbjHHQxk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 12:53:40 -0400
Received: from mail.toke.dk (mail.toke.dk [45.145.95.4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0821A5BB8;
        Tue,  8 Aug 2023 08:58:43 -0700 (PDT)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=toke.dk; s=20161023;
        t=1691501387; bh=U0dmgLydQFvRte01jAQGsjlkNQuow19az3xXPCvMSIA=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=N1FDbpy7axtie2AtcZS1MPmhpp6oH69YNedH6JCoHFL2neBkYgKSeEE0IYYYqvJqO
         FZtfrMgRwAltnMyVWBJHvryLrPGrackR5WB2jxSUsHatAo8HNaDASYcwauQxJacCU9
         xucPZOlNx7/l/TNdkASiKSAb6cj4/rjZEiU1ZCv/bZfNu3eeBpLpO4/v/VqTbPIoZP
         SZBGggQjNXV0cTLsOyVE4MfPy09itGxmMu2WrUNOhKk9uX48g0RNP8yJBVsSR7SzZc
         tVBKgbBhYPeVxQxHp8sI+J8uV6dnODDxm5yuo8RK4bHb3BiRTjzoDNVLdMsVYoTIYL
         6jYwODlMQNKwA==
To:     Wang Ming <machel@vivo.com>, Kalle Valo <kvalo@kernel.org>,
        Rajkumar Manoharan <rmanoharan@atheros.com>,
        "John W. Linville" <linville@tuxdriver.com>,
        Sujith Manoharan <Sujith.Manoharan@atheros.com>,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     opensource.kernel@vivo.com, Wang Ming <machel@vivo.com>
Subject: Re: [PATCH net v1] net:wireless:Fix an NULL vs IS_ERR() bug for
 debugfs_create_dir()
In-Reply-To: <20230713030358.12379-1-machel@vivo.com>
References: <20230713030358.12379-1-machel@vivo.com>
Date:   Tue, 08 Aug 2023 15:29:47 +0200
X-Clacks-Overhead: GNU Terry Pratchett
Message-ID: <87pm3xbr1w.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Wang Ming <machel@vivo.com> writes:

> The debugfs_create_dir() function returns error pointers,
> it never returns NULL. Most incorrect error checks were fixed,
> but the one in ath9k_htc_init_debug() was forgotten.
>
> Fix the remaining error check.
>
> Signed-off-by: Wang Ming <machel@vivo.com>

Acked-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@toke.dk>
