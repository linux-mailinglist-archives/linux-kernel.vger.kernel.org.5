Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C51A8813593
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 17:02:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573951AbjLNQCe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 11:02:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230419AbjLNQCb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 11:02:31 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63A84112;
        Thu, 14 Dec 2023 08:02:37 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id ffacd0b85a97d-3364c9ba749so90002f8f.1;
        Thu, 14 Dec 2023 08:02:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702569756; x=1703174556; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QJ41hRFDTPCl36L/OqktX81t/pEtH3ZPe1LqX+mZtmE=;
        b=B83aglsQpJkeyf95kr/c8P9g/97iIOlfAjxWXd8rCoL008jUmTMEzLITPe0rkCdTNy
         wJThJ9ptv/qxVsuhd5+3j75THQAprWQbZNE4/eLG7O7J7jFTM0jUeRf9U2WfvckI3156
         P41zflFZpSNj+vC9UEYctGBNVYPzq/A3wbZW3vm0leBPT5OGQZJbLBGH9Ek55ITRYVEZ
         l1kBf/78bCy2fOYX2Kh3saTAQ9g/GGKGgan+tlZU5WuwLuGtGIas0y1AI8qhq41gjBjb
         +qc0wZK10HEO6SF3P6I4U/CjnPnN2vsZ2vqoUgVnTMV7zt+pMhe7cbENjoGVjtO8Kv0J
         BnMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702569756; x=1703174556;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QJ41hRFDTPCl36L/OqktX81t/pEtH3ZPe1LqX+mZtmE=;
        b=Y+miku/UgpFx+QG0Lg744//emwN20Bp+m3c4hxihrAi05UKPHNjMv5cHA7+xnrGkY6
         3JO0lLn14fRrNPxMStBqRuvDF15rfpCPvIqOi7A//bsU6O1UWJxwLs3NJdVjPEETIlEk
         UEX4xqg+QJzhGC+6W3FSvq5h8Cz3yfLQhsDw9q+pvydnCYLRYzjkWb2C6mrzPK/nvvUe
         Vyb5nyQyW76km5Az8LRH01c7JLFHyHwUtChRCWZ6fHoff8UN4m/VEAn6CndaQEnO5nzd
         mH3piWGYwgFaMo8dWy690VGsj+7s5i+LV6Em6fdpGsMM+OSlmOuq0QAQ7zt0z/O42wLL
         9l2g==
X-Gm-Message-State: AOJu0YzKihww5SBUtLPs2M6ounMh92/ESzB5kYrz2/Az3KH9W5p14Nls
        8+DhmEULBaqYtFm0IjG6ul9CJcVVWxE3XJ0lGaA=
X-Google-Smtp-Source: AGHT+IG7hWZGSx21e/13fUXWOAKTNGA2NvhpJZ2IgjJgkPCIQP1yknBGnqK36ufv81S3Ewk8SDCkhs+5XZC+8MyH8KI=
X-Received: by 2002:a5d:4982:0:b0:336:460b:fb87 with SMTP id
 r2-20020a5d4982000000b00336460bfb87mr375568wrq.169.1702569755351; Thu, 14 Dec
 2023 08:02:35 -0800 (PST)
MIME-Version: 1.0
References: <1702467945-38866-1-git-send-email-alibuda@linux.alibaba.com>
 <1702467945-38866-2-git-send-email-alibuda@linux.alibaba.com>
 <20231213222415.GA13818@breakpoint.cc> <0e94149a-05f1-3f98-3f75-ca74f364a45b@linux.alibaba.com>
 <CAADnVQJx7j_kB6PVJN7cwGn5ETjcSs2Y0SuBS0+9qJRFpMNv-w@mail.gmail.com>
 <e6d9b59f-9c98-53a1-4947-720095e0c37e@linux.alibaba.com> <CAADnVQK5JP3D+BrugP61whZX1r1zHp7M_VLSkDmCKF9y96=79A@mail.gmail.com>
 <3c1f3b68-f1fc-495c-5430-ba7bc7339619@linux.alibaba.com>
In-Reply-To: <3c1f3b68-f1fc-495c-5430-ba7bc7339619@linux.alibaba.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Thu, 14 Dec 2023 08:02:23 -0800
Message-ID: <CAADnVQLJ3XkZMQDdMGOcKUqK8xuFHcc1+74o6RrzfzeZo7v28A@mail.gmail.com>
Subject: Re: [RFC nf-next 1/2] netfilter: bpf: support prog update
To:     "D. Wythe" <alibuda@linux.alibaba.com>
Cc:     Florian Westphal <fw@strlen.de>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Jozsef Kadlecsik <kadlec@netfilter.org>,
        bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Network Development <netdev@vger.kernel.org>,
        coreteam@netfilter.org,
        netfilter-devel <netfilter-devel@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Alexei Starovoitov <ast@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 14, 2023 at 7:56=E2=80=AFAM D. Wythe <alibuda@linux.alibaba.com=
> wrote:
>
>
>
> On 12/14/23 9:37 PM, Alexei Starovoitov wrote:
> > yes. it's and it's working as expected. Do you see an issue?
>
> Hi Alexei,
>
> I see the issue here is that bpf_nf_link has not yet implemented
> prog_update,
> which just simply returned -EOPNOTSUPP right now.

I see. The commit log didn't make it clear.
Yes. That would be good to support.
