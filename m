Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B602278A039
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Aug 2023 18:45:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229877AbjH0QpG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Aug 2023 12:45:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229787AbjH0Qo4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Aug 2023 12:44:56 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39E69118;
        Sun, 27 Aug 2023 09:44:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=ze7w8GV++/W5Alkw9IxiM745XJDb5+qg93ZRPcqtNVo=; b=tCSirH6E04X/F0h2/B7WH7gwrj
        Q/sZwgZWJG077o53lA4Hi8G6gF880h09U2tixIT+w3R8X/0Rvv19laHab2vuE6GpDXhGyRmNDX5mG
        J5AxMq1EDU6ztfFI6jcbtxItCI3tUA5aEDcWidQAZLizXLIun4/rofwxLhL9iV7vjwA2Mom9qutbE
        ETwn9qQbWZUcKfCRHxnEK35EjOnH4uyHl0udY4VR2K7y/BQ2VAKy8G2wiGPrzMaa6/+AdE4C8cvOr
        6UpJJXWfof9R2b5HgYRyUfeuzM8Zm7bZMQsZXj75vuttVFmv+vb6vsOHD7rCCRMy/hIoTXzpIRLcs
        AsdNraVg==;
Received: from [2601:1c2:980:9ec0::2764]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qaIsV-008G9g-0W;
        Sun, 27 Aug 2023 16:44:43 +0000
Message-ID: <6a3ad63d-5b4d-e861-3fec-2e8fa929e156@infradead.org>
Date:   Sun, 27 Aug 2023 09:44:42 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v3 1/1] scripts: Add add-maintainer.py
Content-Language: en-US
To:     Guru Das Srinagesh <quic_gurus@quicinc.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>,
        Bjorn Andersson <andersson@kernel.org>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, Will Deacon <will@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        quic_pkondeti@quicinc.com
Cc:     linux-kernel@vger.kernel.org, kernel@quicinc.com,
        workflows@vger.kernel.org, tools@linux.kernel.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
References: <cover.1693037031.git.quic_gurus@quicinc.com>
 <141b9fcab2208ace3001df4fc10e3dfd42b9f5d9.1693037031.git.quic_gurus@quicinc.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <141b9fcab2208ace3001df4fc10e3dfd42b9f5d9.1693037031.git.quic_gurus@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 8/26/23 01:07, Guru Das Srinagesh wrote:
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 0903d87b17cb..b670e9733f03 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -8721,6 +8721,11 @@ M:	Joe Perches <joe@perches.com>
>  S:	Maintained
>  F:	scripts/get_maintainer.pl
>  

The MAINTAINERS file should be maintained in alphabetical order,
so this is not in the correct place.

> +ADD MAINTAINER SCRIPT
> +M:	Guru Das Srinagesh <quic_gurus@quicinc.com>
> +S:	Maintained
> +F:	scripts/add-maintainer.py
> +
>  GFS2 FILE SYSTEM
>  M:	Bob Peterson <rpeterso@redhat.com>
>  M:	Andreas Gruenbacher <agruenba@redhat.com>

-- 
~Randy
