Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54FC37C72EC
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 18:31:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379634AbjJLQbg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 12:31:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379625AbjJLQbf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 12:31:35 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6512AC0;
        Thu, 12 Oct 2023 09:31:34 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0334FC433CD;
        Thu, 12 Oct 2023 16:31:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697128294;
        bh=JXim5GrdkpXeREO7B0wcxs2MBI5cT1lmxX3xULvZSEc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=gr5cJwUoJZKS97RqfdmNrup96OW2/6YyI07jxvvwjNzJ6nj+pr2z38gxLQ4vxaXfG
         g0aa95wngXDKsNAyB6I2cGqY1j3BKTOZnGcTlWVKT3d1tK+3RqNkJQ9hgn/ifRaatI
         wlCJC8beXmIU+UE+XgHEJvqtClA+QzqPC/htuRuU8mvqUKqdNciMGZHUDQ9K3X275k
         3CS7J0M9dVoqzp3lD2kfLo6lN+3gwmsgDyUK8MIZnvWR0ghnzGSBlBn9W3WCQNQv0O
         /9YrOx+3Z3M4l/I7Q9Asz5gL1D2263c7+34/DZ3ezr+1Ofd/0boPv2k9pS8guXMuc7
         iwh8RabIN/47Q==
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-505a62d24b9so1537483e87.2;
        Thu, 12 Oct 2023 09:31:33 -0700 (PDT)
X-Gm-Message-State: AOJu0Yx9iOD+CltMbtpLm+asvziEcWp1DZR2I4uK7Ekv9yYmoY4vOpUm
        mLQZrZ7W9M6GmKrb+VwQa/GYXzNPlXwsX82z1pk=
X-Google-Smtp-Source: AGHT+IHRJ05LP40unJii5NxjwAPAeXOGYT+YjQ1BFGmvvN+O+cwvjNw2YKNV71FaVg1yeI1FLi7x8QoZ1uQtVzICJXM=
X-Received: by 2002:ac2:505a:0:b0:502:ab7b:e477 with SMTP id
 a26-20020ac2505a000000b00502ab7be477mr20668195lfm.53.1697128292130; Thu, 12
 Oct 2023 09:31:32 -0700 (PDT)
MIME-Version: 1.0
References: <20230925125940.1542506-1-den-plotnikov@yandex-team.ru>
In-Reply-To: <20230925125940.1542506-1-den-plotnikov@yandex-team.ru>
From:   Song Liu <song@kernel.org>
Date:   Thu, 12 Oct 2023 09:31:19 -0700
X-Gmail-Original-Message-ID: <CAPhsuW6SkP8vq7yYWTrUkCGvtzQqxG-O_Xj5__park4VnDYs6Q@mail.gmail.com>
Message-ID: <CAPhsuW6SkP8vq7yYWTrUkCGvtzQqxG-O_Xj5__park4VnDYs6Q@mail.gmail.com>
Subject: Re: [PATCH] md-cluster: check for timeout while a new disk adding
To:     Denis Plotnikov <den-plotnikov@yandex-team.ru>
Cc:     linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 25, 2023 at 5:59=E2=80=AFAM Denis Plotnikov
<den-plotnikov@yandex-team.ru> wrote:
>
> A new disk adding may end up with timeout and a new disk won't be added.
> Add returning the error in that case.
>
> Found by Linux Verification Center (linuxtesting.org) with SVACE
>
> Signed-off-by: Denis Plotnikov <den-plotnikov@yandex-team.ru>

Applied to md-next.

Thanks,
Song
