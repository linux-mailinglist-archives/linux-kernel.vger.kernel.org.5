Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69EFD7AF7AD
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 03:25:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235061AbjI0BZ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 21:25:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233631AbjI0BXY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 21:23:24 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF2FB4689;
        Tue, 26 Sep 2023 15:49:45 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id ca18e2360f4ac-79fc3d32a2fso198506939f.1;
        Tue, 26 Sep 2023 15:49:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695768585; x=1696373385; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/Df3ltePaVkzArGrvmVOaM/ekEhRgKC5O//KqFjWivU=;
        b=I+hK9pvlu7fdjVmKpOxjYtGRVKYbs73gaNAHLbjQQm62G/OFIC53D1If2v1lsbYlHE
         hLFs0WJqhj2YokCK0adcZWXchLpnhu50EP3/xSGGSrygd1jUdxb+g5JTaGpYvxUVIyqg
         IAHqD+/aYIkq0muiIHEXmKcpSi76GBH09dFHuIYv1uD2KIN84lvQ/K3Br9eBzvyWPkT9
         67+tAnh4InVR6yv0RnTPaddKl20lD89i5vYrnpdxBnZNRrGjvF35M7tLTqjft2PyBrRw
         QhaqZjwGVL9JoPlSDNKYbEzGx27RPwoXaFhXhXBfWAZZ/nJRKuznwvHq8ywrUdAZvG1V
         11GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695768585; x=1696373385;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/Df3ltePaVkzArGrvmVOaM/ekEhRgKC5O//KqFjWivU=;
        b=W4m/rW+cJBKXvIxCuF8Twoli8SoeTSQoZf31Ljb9Rb6ezNrTNd6DUHNx1rxqu0nEzC
         c77z8049NYRyMhWMZ3MrhWwxd/7L3VgxS6qsOce0QKej/N2/EUXJEnT0KjMTejgNTRXL
         v3s1Rr6NFKRw++h2zkzANZIq3XMIlAeeVY3B1R5aKejWFvGNb0qJxTX43R6hswcewLE2
         Pm1N5+gWZmRnfQyCWbZGIutwS+8QVcMkpnuKabX8NDU4oMDk5UZ2pajyzBgdVybjKzjk
         XUwjLsZ9jhVqBssB8ZFz3IckuZ52Nm3le6bha+KoosmRDU+sLEWy0Tq3UmGj0FMG4ytf
         EFSg==
X-Gm-Message-State: AOJu0YyMbiHHNILVEJ7GQ0lhhAdCnGMR8pBTAhSGB/hJKjHY40c9R53F
        L3VMX8wvxVLK+IBxVuiPPkPZiGFfqScOJMBOQz8=
X-Google-Smtp-Source: AGHT+IH3CFM83n4FXQjH/BgqIeyeRek8hxoCtWScMz1UTsmwAwRsIAXd34a2OyzWoRXr5akPbZBSYC22S85dgrteypY=
X-Received: by 2002:a5e:c241:0:b0:794:e96f:b87d with SMTP id
 w1-20020a5ec241000000b00794e96fb87dmr302231iop.0.1695768585012; Tue, 26 Sep
 2023 15:49:45 -0700 (PDT)
MIME-Version: 1.0
References: <20230918033623.159213-1-hanchunchao@inspur.com> <CAP-5=fWUDgrD-Ehw1hk+L0bYeCVwve+J+=EptgUM4o+GR55YzQ@mail.gmail.com>
In-Reply-To: <CAP-5=fWUDgrD-Ehw1hk+L0bYeCVwve+J+=EptgUM4o+GR55YzQ@mail.gmail.com>
From:   Namhyung Kim <namhyung@gmail.com>
Date:   Tue, 26 Sep 2023 15:49:34 -0700
Message-ID: <CAM9d7ciX6rxJWan6O-V2fDja5rNEF5YvDKO_N+QoyKTO2eBUWg@mail.gmail.com>
Subject: Re: [PATCH] perf vendors events: Remove repeated word in comments
To:     Ian Rogers <irogers@google.com>
Cc:     Charles Han <hanchunchao@inspur.com>, john.g.garry@oracle.com,
        james.clark@arm.com, mike.leach@linaro.org, leo.yan@linaro.org,
        peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@kernel.org, adrian.hunter@intel.com, nick.forrington@arm.com,
        ilkka@os.amperecomputing.com, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 20, 2023 at 5:02=E2=80=AFPM Ian Rogers <irogers@google.com> wro=
te:
>
> On Sun, Sep 17, 2023 at 8:36=E2=80=AFPM Charles Han <hanchunchao@inspur.c=
om> wrote:
> >
> > Remove the repeated word "of" in comments.
> >
> > Signed-off-by: Charles Han <hanchunchao@inspur.com>
>
> Reviewed-by: Ian Rogers <irogers@google.com>

Applied to perf-tools-next, thanks!
