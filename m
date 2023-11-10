Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25C6A7E8165
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 19:28:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235598AbjKJS1b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 13:27:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346060AbjKJS0C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 13:26:02 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0B1239CD7
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 06:48:46 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-9df8d0c2505so439495466b.0
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 06:48:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1699627725; x=1700232525; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZaMy0qRFyEah4E1tWT+kGJHayhlqeA9A26QIZGygrDo=;
        b=eTP4MkX50Nv1sjGkxsiFyTY7RggFMXAJ2uHFRKkhGu+9IxCOkEBZObzGgfc91Pk2qW
         jbj0QWJZdybtBEVNve6dm9MfUQ2l848oGNn3gBJdOBIMKYXrxXQP5z54cyvCFUMlqp6G
         x5BwtPqLk8pQbC1CBaRcytDDVs72mkjEFXY7n7SqrsFbdKUZf587Ujh7RxKSNRll99+R
         64KQtd4zyQgXiTRZ3HkRCtbj1uR4vKoE7bqonm7Gw9ZG8DIP4bFtplXdtDcZtSZ6Tz7f
         y3aJhS10j3Z28n+DnOQkJYogVKvRRvbaIThdtQaGmV7vqi9X0OEFIPgNKI4I7+BOvxhG
         4yNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699627725; x=1700232525;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZaMy0qRFyEah4E1tWT+kGJHayhlqeA9A26QIZGygrDo=;
        b=QHsPk/7O/b8Hl6VFyNt1347DZbx/wMp+DlLE8rmPxXxEn9Zvdfp1qPsmp0cAbZFRoM
         IPdQfYKWjosfaTJhwkXzvQGCIrbwmDJ+cUGcGkpN8Fl+fZWRLNAlbAFayN/CjarRg5da
         gKbJGXt7+tmPSJHvc1vFrX/uYIdzZj9zuzkILIp+Ps8rZdR+GXyj0wysEM6P2O+1Sqk/
         XLTlG9To9SEF/7AwVu7gRPwnamJHxTtfgrhXkC+HaDh3Mqx9i4kTTOmSVaCEpMOR7DBM
         /gg0dP+Ov5TJsLTSAPEp7oYLRM0WH9gaJYUs9rHQTn/haJtE2O+U8XrwdaoepCMBIXwI
         zlWQ==
X-Gm-Message-State: AOJu0Yx4wPz4FRquOpNtlFUS6Ts5zjpcxQcLYhdqWunP8VmD5mwdCrCz
        7dFPudguCbBzmWCxghNL19NBVpP6hqFlMmhQ8Y0GOgaYRzU4u2H/tuw=
X-Google-Smtp-Source: AGHT+IEqVdEpCw1dHu9v/q6rlF1qRuIjQPsHV1exJOC+CBiyhmcWiGrAtpbfM0YsO9SbbBEtC4wUh7b1tJ46lUlLexU=
X-Received: by 2002:a17:906:f259:b0:9e5:d56d:d455 with SMTP id
 gy25-20020a170906f25900b009e5d56dd455mr2553996ejb.1.1699627725137; Fri, 10
 Nov 2023 06:48:45 -0800 (PST)
MIME-Version: 1.0
References: <ZU3EZKQ3dyLE6T8z@debian.debian> <CANn89iKZYsWGT1weXZ6W7_z28dqJwTZeg+2_Lw+x+6spUHp8Eg@mail.gmail.com>
In-Reply-To: <CANn89iKZYsWGT1weXZ6W7_z28dqJwTZeg+2_Lw+x+6spUHp8Eg@mail.gmail.com>
From:   Yan Zhai <yan@cloudflare.com>
Date:   Fri, 10 Nov 2023 08:48:34 -0600
Message-ID: <CAO3-PbqSXjMrYKovoUJK5FhfD=zpkKosVbK2UtAARa0VEFzuGQ@mail.gmail.com>
Subject: Re: [PATCH net-next] packet: add a generic drop reason for receive
To:     Eric Dumazet <edumazet@google.com>
Cc:     netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        Weongyo Jeong <weongyo.linux@gmail.com>,
        Ivan Babrou <ivan@cloudflare.com>,
        David Ahern <dsahern@kernel.org>,
        Jesper Brouer <jesper@cloudflare.com>,
        linux-kernel@vger.kernel.org, kernel-team@cloudflare.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 10, 2023 at 3:31=E2=80=AFAM Eric Dumazet <edumazet@google.com> =
wrote:
> it is time we replace the various constructs which do not help readabilit=
y:
>
> if (something)
>      consume_skb(skb);
> else
>      kfree_skb_reason(skb, drop_reason);
>
> By:
>
> kfree_skb_reason(skb, drop_reason);
>
> (By using drop_reason =3D=3D SKB_CONSUMED when appropriate)
Will send a V2 when net-next reopens
