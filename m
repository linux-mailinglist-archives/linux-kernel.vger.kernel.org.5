Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 313967B578B
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 18:13:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237986AbjJBPvr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 11:51:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238224AbjJBPvp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 11:51:45 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16196BD
        for <linux-kernel@vger.kernel.org>; Mon,  2 Oct 2023 08:51:42 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-99bdcade7fbso2253812766b.1
        for <linux-kernel@vger.kernel.org>; Mon, 02 Oct 2023 08:51:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1696261900; x=1696866700; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zpFVhwvvyKOhe8Ad0bzCkIEDZEU9f12oQEadNgJFOWA=;
        b=Ch1B0tg+T1Eu7ArABnLtTsuSuDUzqmBMn2jhxq7lyucESabNXHp8OHfHitOkee0RHq
         +v2iQd2eMF/VNspPXdTQg3vQCTpYlx7suuNZ9QXseoXd0we2YF/kTM2tH3LCS1Yqqcu/
         ykQzDAQZjmQXSFAi5DANkeA+qGCYQKjpBSiURlWhY44gGMgtRuGWkXM9E25tLhqoP8d+
         vAJPOnKhAjloddDaTufWEOfDXTiGTeQuVW0kbF09uM7CdmWkzSB9pq6DWGPhBQoLj8lX
         W4B799PzyLU3Iv/Pj1WCcsBZaTYNBT5GwyCVM4oCiRNMYcYsNTYn51YfQJaG4L+lxTYl
         hXRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696261900; x=1696866700;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zpFVhwvvyKOhe8Ad0bzCkIEDZEU9f12oQEadNgJFOWA=;
        b=Q8tW08dpMFMe8UpFn1ulsZyyjC7PTclCuxxK8eu+uIeWI/B079kuAOCy2xbh+oGw0G
         8mgvGn2Ve1HR3wMdJgIg56kC8KN+Qg53MENGcLpJHb0WtygcDx7Mkin/ozr/RJlEGBEU
         F4ABL4Jkrv/V0y+3NbtKBg1TG8usFcJTTrnW8kPSdtX1irmRbksIAqflsjGQnc0Yujkk
         4N5z6yh20ypHpY6BYOVZgJXYlqBeQe1C1s7IUIl8Vsm0Hlk9/S487yv5+6kHxQiqNz+8
         u1Q4yryRWKOSWO/9GJDh3RdH103oVm9UXTec/GqL/Wt7FOdfVM9hMGV5jcKxTj8WuWwY
         8vWA==
X-Gm-Message-State: AOJu0YzGBiAFyjh6nBnDyWUMj0rMFFE9hYTydTKEhhhTpGGJEPRm635P
        5PntbwWFTZcrlxjwAsck8kWI/eufS9fazp/bhqzT7Q==
X-Google-Smtp-Source: AGHT+IFq5bmkuGiToH1F0K2G2b1y3FT9p5rJjAGCpVshgz+oirRuPTK3PQzffnVUecToJJXkWRVuv1IXYmxeAADVNf0=
X-Received: by 2002:a17:906:739b:b0:9ae:38d0:ef57 with SMTP id
 f27-20020a170906739b00b009ae38d0ef57mr10221900ejl.66.1696261900467; Mon, 02
 Oct 2023 08:51:40 -0700 (PDT)
MIME-Version: 1.0
References: <ZRcOXJ0pkuph6fko@debian.debian> <20230930110854.GA13787@breakpoint.cc>
 <CAF=yD-JR8cxEt6JRhmMyBFucyHtbaKrarDh=xN7jeT2obBsCRQ@mail.gmail.com>
In-Reply-To: <CAF=yD-JR8cxEt6JRhmMyBFucyHtbaKrarDh=xN7jeT2obBsCRQ@mail.gmail.com>
From:   Yan Zhai <yan@cloudflare.com>
Date:   Mon, 2 Oct 2023 10:51:29 -0500
Message-ID: <CAO3-PbrN1fXsWoPeKn0swbBRihuUfRjMfXxKHo47USHhiSdwMw@mail.gmail.com>
Subject: Re: [PATCH net] ipv6: avoid atomic fragment on GSO packets
To:     Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc:     Florian Westphal <fw@strlen.de>, netdev@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        David Ahern <dsahern@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Aya Levin <ayal@nvidia.com>,
        Tariq Toukan <tariqt@nvidia.com>, linux-kernel@vger.kernel.org,
        kernel-team@cloudflare.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 2, 2023 at 1:53=E2=80=AFAM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
> To add to that: if this is a suggestion to update the algorithm to
> match RFC 8021, not a fix for a bug in the current implementation,
> then I think this should target net-next.

Ack
