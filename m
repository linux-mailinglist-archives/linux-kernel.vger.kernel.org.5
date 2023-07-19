Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71C14759F29
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 22:01:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231315AbjGSUBj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 16:01:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229853AbjGSUBh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 16:01:37 -0400
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45E9292;
        Wed, 19 Jul 2023 13:01:35 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id 3f1490d57ef6-cb4de3bd997so1795129276.1;
        Wed, 19 Jul 2023 13:01:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689796894; x=1690401694;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=stu+6/j3HbnPj0KRDFW+4OZ7RsJiQvUoKxDl73j6SMY=;
        b=cY5xHQ7xgHbVGZF6SIYA44/9ljfF0XdAsQA/RJujiVeWYdI9LdiiQGqhJiwRyHLNCl
         HE/tZn8c1YNS50/ZxnW9EUBjhznIuwFxFeEDD/cNsRKzKxSfVO9+N+J7GRkleuij0FP7
         mfMbsqJe5YNxup7OzbRysbg7/O3P85ErksLhD+68yquOIg+3QTagsbdukzI39R1DDfZ1
         v14cXn10OpAdbgX6W6m/7QWfVT7fbBrBoqlfigUFGCXSLhg2e/PH8FRMySp0dlG0mKUL
         9wHgS5HdT200ELRgeGcuAmc8Ahi57LBvOlClPmMZlh0x194ibBPktQqbI5FIqes0/qGV
         9ZrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689796894; x=1690401694;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=stu+6/j3HbnPj0KRDFW+4OZ7RsJiQvUoKxDl73j6SMY=;
        b=fFVH6Y59EUMIiBD6p9HjhBOFcZYC4twdUBA+uf2YJH92W6i3D1wMQoL8mhbNi7ci4j
         1D7mMYkXXUMM7bXcSFU/wfQEwL65sAXPyd4Pd6WHmHpeKPi7gOv1mWYZ3HJITw1aLopz
         6sTza0qRunZ2JixbyeYNQDyt9Q1XWxPgOBcPkk91DGzxzYNm2B1VbEih5M7Rtb3MeM9R
         oA52QQxbPz/6DSPlcguNMWCSvGuT2QW2GK8afQ8Xk7LHMejLmEJGGPhJJlljtp/LHXGO
         Iwoil0NpoFf3my4Vk8dda75bgfsdexTH9I/8Zl/L3iewkif0YXMlrmF2WLMqlce52Lis
         Htig==
X-Gm-Message-State: ABy/qLZ0xmVIN8tvD0X/ui6o3c9UoPEXYxNlP+Y9GjA2Gvs/UkSlVx4N
        cO8deSpnxTwYzQ9EuW58r7l8OgocNTnzxlyCW7sNCc4/MKg=
X-Google-Smtp-Source: APBJJlGOXTxMetMf8KW+6Eh/OrQPukURd838S4EXYF6N5QJWweVDtUowyEnHyPNBLXwUTHha/gJGbaD+AsCzL6p3rYY=
X-Received: by 2002:a25:ff19:0:b0:cfc:d478:be7e with SMTP id
 c25-20020a25ff19000000b00cfcd478be7emr289348ybe.10.1689796894314; Wed, 19 Jul
 2023 13:01:34 -0700 (PDT)
MIME-Version: 1.0
References: <CANiq72nm-tWGPHMaNF11baVRDFpk8ruvTAVDEWKfraEzADWqQQ@mail.gmail.com>
 <20230426204923.16195-1-amiculas@cisco.com>
In-Reply-To: <20230426204923.16195-1-amiculas@cisco.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Wed, 19 Jul 2023 22:01:23 +0200
Message-ID: <CANiq72npkGJ0=_C4JacaEBvujaT34TO6vqM1UzYVKH0+b+cjzQ@mail.gmail.com>
Subject: Re: [PATCH v3] rust: helpers: sort includes alphabetically in rust/helpers.c
To:     Ariel Miculas <amiculas@cisco.com>
Cc:     rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        ojeda@kernel.org, alex.gaynor@gmail.com, wedsonaf@gmail.com,
        boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com,
        benno.lossin@proton.me
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 26, 2023 at 10:50=E2=80=AFPM Ariel Miculas <amiculas@cisco.com>=
 wrote:
>
> Sort the #include directives of rust/helpers.c alphabetically and add a
> comment specifying this. The reason for this is to improve readability
> and to be consistent with the other files with a similar approach within
> 'rust/'.
>
> Suggested-by: Miguel Ojeda <ojeda@kernel.org>
> Link: https://github.com/Rust-for-Linux/linux/issues/1003
> Signed-off-by: Ariel Miculas <amiculas@cisco.com>

Applied to `rust-next`, thanks!

Cheers,
Miguel
