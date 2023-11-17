Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2B7F7EF82D
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 21:10:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232163AbjKQUJj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 15:09:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232311AbjKQUJi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 15:09:38 -0500
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45D80D75;
        Fri, 17 Nov 2023 12:09:35 -0800 (PST)
Received: from localhost (unknown [98.53.138.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id B297044A;
        Fri, 17 Nov 2023 20:09:34 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net B297044A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1700251774; bh=XDY+wGPvrcfTDlV+CkWycIiMf+luuMERPm1C/YmRvB8=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=tMjZQEE5LwZ5PqHZpRtwmOC9+Lx0ucGWa/v6i/cYeA0XBjrJhvha+EwFKTSrpDjTQ
         OLywCBL8Uqg5PG6VwLI0/yiYxcBO+AD02x4FehBvrUjFEgHyOj2jWGmSGFVdd3SvD2
         /vQPCAdtvkpejJc7jGRqd3IkSad1qgOi0YSuS4nLJgAFAJIxdwoVoofFGyb6fE/ND7
         NaJFI50VEZL9mK1403oilWnAigF5WTAYF+mf/7C7xdmplAwFD0xuYc4ViLZ0/TMDYd
         LKt2IZJduu5svyNli+8jsBahqWv59hniHnuMI9F8QgVXaxB1BnATCEEdcEW7fhxpH+
         Ul0TcoVUHpMeQ==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Vegard Nossum <vegard.nossum@oracle.com>,
        linux-doc@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Jani Nikula <jani.nikula@intel.com>, linux-kernel@vger.kernel.org,
        Vegard Nossum <vegard.nossum@oracle.com>,
        Alex Shi <alexs@kernel.org>, Armin Wolf <W_Armin@gmx.de>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Fangrui Song <maskray@google.com>,
        Federico Vaga <federico.vaga@vaga.pv.it>,
        gaochao <gaochao49@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Hu Haowen <src.res.211@gmail.com>,
        Iwona Winiarska <iwona.winiarska@intel.com>,
        Julien Panis <jpanis@baylibre.com>,
        Ricardo =?utf-8?Q?Ca=C3=B1uelo?= <ricardo.canuelo@collabora.com>,
        Richard Cochran <richardcochran@gmail.com>,
        Rui Li <me@lirui.org>, SeongJae Park <sj@kernel.org>,
        Stephan Mueller <smueller@chronox.de>,
        Tomas Winkler <tomas.winkler@intel.com>,
        Wan Jiabing <wanjiabing@vivo.com>,
        Wu XiangCheng <bobwxc@email.cn>,
        Yanteng Si <siyanteng@loongson.cn>
Subject: Re: [PATCH RFC 00/11] use toctree :caption: for ToC headings
In-Reply-To: <20231027081830.195056-1-vegard.nossum@oracle.com>
References: <20231027081830.195056-1-vegard.nossum@oracle.com>
Date:   Fri, 17 Nov 2023 13:09:24 -0700
Message-ID: <87ttpk87m3.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Vegard Nossum <vegard.nossum@oracle.com> writes:

> Hi,
>
> This patch series replaces some instances of 'class:: toc-title' with
> toctree's :caption: attribute, see the last patch in the series for
> some more rationale/explanation.
>
> There are some dependencies here: the first patch is necessary for the
> headings in following patches to be styled correctly with the alabaster
> theme (rtd_sphinx already has it), and the last patch depends on most
> of the previous patches to not use the old .toc-title class anymore.
>
> Assuming people agree with the general direction, I thought maybe the
> easiest thing would be to collect maintainer acks in this round and
> then for me to resubmit everything to the documentation tree/maintainer
> in one go.

Easiest thing seems to be for me to just apply it, so I've done that.
It would have been a bit easier if you'd worked against a recent
docs-next, but so it goes...

Thanks,

jon
