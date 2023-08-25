Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3854D788B7D
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 16:18:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245616AbjHYOSL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 10:18:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344054AbjHYOSG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 10:18:06 -0400
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 017212682;
        Fri, 25 Aug 2023 07:17:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
        bh=97b0JfQGSNXqXd4NigawyuOiSD9yyLhmMPvce7xdAJo=; b=bZk9slxNMCK8YfIOmLcT8bDoQ+
        CF+iY2j2oqXiKFmSR7+zwzbCqwEpYA5VISyStJg2Tttg/Pl3MZ5WGrNerwHBT4gigZU31jLXYn76A
        ulpj+UZiVCyzAmkOup3aEDwMe4Jh6rUWaKfaY758KyVI/8kFRMxeEX/wkfhKFZh/iw5Ya5CKrKYNE
        Uz9+CUnyciMsTGggroLM4tSx5DHd8kufPkmohiyotTXibwExH6WZq/urzgWF6RnzMzM+IvmNaHVKP
        eW+Hor8lFEYZ6rXt9YH9AQZEdDShegK83YSVFG2kS7ZdaG3RxubcGPwsqji2crERVvpByraHyFT4M
        Yl2Bf2lg==;
Received: from sslproxy01.your-server.de ([78.46.139.224])
        by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <daniel@iogearbox.net>)
        id 1qZXcI-000Hqa-5E; Fri, 25 Aug 2023 16:16:50 +0200
Received: from [85.1.206.226] (helo=linux.home)
        by sslproxy01.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1qZXcH-000OoA-W6; Fri, 25 Aug 2023 16:16:50 +0200
Subject: Re: [PATCH 1/2] Documentation: sphinx: Add sphinx-prompt
To:     Nishanth Menon <nm@ti.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        bpf@vger.kernel.org,
        Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
        Mattijs Korpershoek <mkorpershoek@baylibre.com>,
        Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
        Neha Francis <n-francis@ti.com>
References: <20230824182107.3702766-1-nm@ti.com>
 <20230824182107.3702766-2-nm@ti.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <149528e1-062b-ebed-aa25-d37be5fe5894@iogearbox.net>
Date:   Fri, 25 Aug 2023 16:16:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20230824182107.3702766-2-nm@ti.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.8/27011/Fri Aug 25 09:40:47 2023)
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/24/23 8:21 PM, Nishanth Menon wrote:
> Sphinx-prompt[1] helps bring-in '.. prompt::' option that allows a
> better rendered documentation, yet be able to copy paste without
> picking up the prompt from the rendered documentation.
> 
> [1] https://pypi.org/project/sphinx-prompt/
> Link: https://lore.kernel.org/all/87fs48rgto.fsf@baylibre.com/
> Suggested-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
> Suggested-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> Signed-off-by: Nishanth Menon <nm@ti.com>

Given the patch 2/2 is targeted for bpf docs, we can route this via bpf-next.
Jonathan, could we get an ack for this one if it looks good to you?

Thanks,
Daniel
