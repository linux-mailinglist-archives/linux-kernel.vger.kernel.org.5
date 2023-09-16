Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90A2B7A2F55
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Sep 2023 12:53:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239038AbjIPKxZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Sep 2023 06:53:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238997AbjIPKxQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Sep 2023 06:53:16 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8594BE3;
        Sat, 16 Sep 2023 03:53:11 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id ffacd0b85a97d-31ff2ce9d4cso1438619f8f.0;
        Sat, 16 Sep 2023 03:53:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1694861590; x=1695466390; darn=vger.kernel.org;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E6++5ofz/XVp0r1sKsCzLslu6+YsvGovl/0af+/t0Io=;
        b=Clnr93WbuY7T7n4miHfo8AS+6F78zVl7uj+Zha4kWJCumTRqREaxmEHmxqWJB3TE5N
         6WKRN8VEoxb8Ns3QS6RytORovnZuvpHMTOi/ub9SRQ56fXK9AefB1G7jltoflw3+Ey0l
         ZW9J3jC1IhQBymJBYKSxONw8FmuhmIHQpIobkQoP7jBHoGj9tMEuKfdQq/e2zY+24JRW
         uORtd/NQ0W7gMYEtRu0iCaH4zquyPyu7csXIiyisL7eH9YgTQrOdt+49g5GzFQG3jGwX
         i1dyaZPgA8s42I/nijlJXBKbPmi0HjJQdRdMxv8K/5jMR3psORNrsH7BlPJzW58n98W3
         oCQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694861590; x=1695466390;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=E6++5ofz/XVp0r1sKsCzLslu6+YsvGovl/0af+/t0Io=;
        b=frt3slljOcQCdVtferigeyi7kIFDNalV2jdLH7xrs+nIyf0gKvuacuiZwKECQo6A3M
         tn4tW1VUQNL84UcMAcRHrSCnh5Jib0pEOxe9RbFidL98jIeCXwkpNNO3JTPfj/e6gSxc
         P7ozihM+EO0/MP6wMTgvTDXwHumDTd76PPx1ALqRiR0/p36JZ6lU1BSAP968GxRY0ePt
         Ra/MuWVQOpQy0it8kHXqxvU9pa0FXfWCGyTnyudeumt8Xm5ookslhvfqISpLfBizoyqg
         4sdmjKJxxJndyx55f96EwM2mwuOgx4lME2zywOLLMXB0VWWKsUld7JMzPxyUkS5ZFzYE
         dKcw==
X-Gm-Message-State: AOJu0YxIOTvi39GHx4Yfej1MNfsvD0C4j12WrDlGOkh4ecQTs64Wq7yt
        PJulVTclSFdQb2ug/9TGhPM=
X-Google-Smtp-Source: AGHT+IE9iYdti2ESeNV0y7KhQoMbN+Ztv4NNyQYjs2YsSmiRyiYMcX7eVbsM8hDYzjaHn3x5C/E4cg==
X-Received: by 2002:adf:f34f:0:b0:317:e1fb:d57b with SMTP id e15-20020adff34f000000b00317e1fbd57bmr3282990wrp.56.1694861589528;
        Sat, 16 Sep 2023 03:53:09 -0700 (PDT)
Received: from localhost ([45.134.213.210])
        by smtp.gmail.com with ESMTPSA id t3-20020a5d5343000000b00317ab75748bsm6852110wrv.49.2023.09.16.03.53.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 16 Sep 2023 03:53:09 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Sat, 16 Sep 2023 12:53:08 +0200
Message-Id: <CVKAAGQ6QV0W.3LCCSR4PNZKDC@vincent-arch>
To:     "Miguel Ojeda" <ojeda@kernel.org>,
        "Wedson Almeida Filho" <wedsonaf@gmail.com>,
        "Alex Gaynor" <alex.gaynor@gmail.com>
Cc:     "Boqun Feng" <boqun.feng@gmail.com>, "Gary Guo" <gary@garyguo.net>,
        =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        "Benno Lossin" <benno.lossin@proton.me>,
        "Andreas Hindborg" <a.hindborg@samsung.com>,
        "Alice Ryhl" <aliceryhl@google.com>,
        <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <patches@lists.linux.dev>
Subject: Re: [PATCH 2/2] MAINTAINERS: add Maintainer Entry Profile field for
 Rust
From:   "Vincenzo Palazzo" <vincenzopalazzodev@gmail.com>
References: <20230830165949.127475-1-ojeda@kernel.org>
 <20230830165949.127475-2-ojeda@kernel.org>
In-Reply-To: <20230830165949.127475-2-ojeda@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> The `P:` field allows a URI, and we have been adding information
> on how to contribute to the Rust subsystem to our webpage for a
> while now (and other relevant topics, e.g. branches, third-party
> crates, Rust unstable features...).
>
> The webpage/document does not currently follow the headings of
> the Maintainer Entry Profile, but it does nevertheless answer
> some of the questions we have got so far from contributors and
> it covers partially some of the topics there.
>
> Thus link to our "Contributing" document [1].
>
> Link: https://rust-for-linux.com/contributing [1]
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>

Reviewed-by: Vincenzo Palazzo <vincenzopalazzodev@gmail.com>
