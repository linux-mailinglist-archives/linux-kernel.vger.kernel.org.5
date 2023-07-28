Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 987FC766AF7
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 12:47:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235520AbjG1KrE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 06:47:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233660AbjG1KrC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 06:47:02 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6EBFC0;
        Fri, 28 Jul 2023 03:47:01 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 764225C0101;
        Fri, 28 Jul 2023 06:46:59 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Fri, 28 Jul 2023 06:46:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1690541219; x=1690627619; bh=zE
        uCJaOzZh+kBMJcn4jBJfpUMI5wNH9AosgDceJjJKc=; b=MTuWCUeFiHnLM2pwyo
        zxp7ZCSmgM5/ugQQxma3Fu8kFrD8gVNAvaeI1F+n4ZQ9+QIN/r9bNQ8rDTH5u4mX
        oMUSp3YvTKphMsBOfe/yEqOyPOKZlK1eldq6fVlU3vIxG5B0ixRomK5Qa/DZhdMk
        0sRxHDL3VaXX2lxI16n/jmP9SIjkz8Jrg8oF7wdTUGeqp4wt1cJkvZBPbRkpw5zk
        f6V8wBTwuCQtQHXwrUuDcOTJqgNTWnqj/hTi1pOj5G66x5UGX0w+dp5RM76MRW9b
        7WoPEXugDvpMIVay2TFPSLMYZ+Emv8Ykib2mZ3byADE6Mqpj0sSV+aJljddvptan
        bLLA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1690541219; x=1690627619; bh=zEuCJaOzZh+kB
        MJcn4jBJfpUMI5wNH9AosgDceJjJKc=; b=2ujtNkF3iobFUBQyjYpHbbTVpTvJU
        9oSuSnziGy+Bo073zVeiCXjQqqwmuS12JnK1xOL4EG72nmAbYjV23Cwv1sY5kR5V
        QgGcwRAAT4Hdiy4+zOODXp6AD4bDozYEZkbkKQYbMe144L014OYZrL2TPqTA9wri
        g6lDD5R77Mm2SxtFDXmwDHd5/KyCE+P8scwM9ndL/ZzK1JLFwsiGQUVUrPmpuhEv
        j+g2XRVJA8MfCqddOmxlHWiSgkWiFxxdib3eHwB1vFSSiogcY1Ow/Elb+eIYjE64
        6BVmk+QFMO0gaCDIY+zD+VW2huel7ydKXiR40M/OcUXuBsxayp7AoP89g==
X-ME-Sender: <xms:opzDZI98trAehFkKvf0kk9fihbJRsmAQzapfWOLZKgbbdw8ftdgdZQ>
    <xme:opzDZAufZU8eWY7n3t6ViaPBoSVBnykIOr8WrmBLRwlAxcIShNp6sC2t37gNFUI_b
    wE3MY83GuzT3Z2Nm5Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrieeigdeftdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdetrhhn
    ugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtth
    gvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedtkeet
    ffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrh
    hnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:opzDZODxrDq_NX-fn6UaZDVNvSQ8gnIWWtYQzI3_pLPouFR8CWVPxw>
    <xmx:opzDZIeoVdzIIKh3hfCd-F5sTKHEJoQZBCi_Tmg1mjwKbGRZcqW9xQ>
    <xmx:opzDZNPPmXCwiknk_tolo-KHDUmIfV5YE7HEwzws9iW-CeT3kr2vaA>
    <xmx:o5zDZOH8r6YJfRUXBUtBjfhh1QpKi1zyrUR9vMkpRu2akCLQCyGUag>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 1563CB60089; Fri, 28 Jul 2023 06:46:57 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-592-ga9d4a09b4b-fm-defalarms-20230725.001-ga9d4a09b
Mime-Version: 1.0
Message-Id: <569a1c8e-234a-442f-9b9e-956f5bac26dc@app.fastmail.com>
In-Reply-To: <20230728074944.26746-3-zhuyinbo@loongson.cn>
References: <20230728074944.26746-1-zhuyinbo@loongson.cn>
 <20230728074944.26746-3-zhuyinbo@loongson.cn>
Date:   Fri, 28 Jul 2023 12:46:37 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Yinbo Zhu" <zhuyinbo@loongson.cn>,
        "Rob Herring" <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        "Conor Dooley" <conor+dt@kernel.org>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Ulf Hansson" <ulf.hansson@linaro.org>
Cc:     "Jianmin Lv" <lvjianmin@loongson.cn>, wanghongliang@loongson.cn,
        "Liu Peibao" <liupeibao@loongson.cn>,
        loongson-kernel@lists.loongnix.cn, "Liu Yun" <liuyun@loongson.cn>
Subject: Re: [PATCH v5 2/2] soc: loongson2_pm: add power management support
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 28, 2023, at 09:49, Yinbo Zhu wrote:
> The Loongson-2's power management controller was ACPI, supports ACPI
> S2Idle (Suspend To Idle), ACPI S3 (Suspend To RAM), ACPI S4 (Suspend To
> Disk), ACPI S5 (Soft Shutdown) and supports multiple wake-up methods
> (USB, GMAC, PWRBTN, etc.). This driver was to add power management
> controller support that base on dts for Loongson-2 series SoCs.
>
> Co-developed-by: Liu Yun <liuyun@loongson.cn>
> Signed-off-by: Liu Yun <liuyun@loongson.cn>
> Co-developed-by: Liu Peibao <liupeibao@loongson.cn>
> Signed-off-by: Liu Peibao <liupeibao@loongson.cn>
> Signed-off-by: Yinbo Zhu <zhuyinbo@loongson.cn>

Adding Ulf Hansson to Cc

Ulf has recently split out the "genpd" framework and split out
drivers/genpd from drivers/soc since I'm generally not that involved
in the pwoer management side.

Can you have a look at whether this driver should also be part
of drivers/genpd rather than drivers/soc, and/or converted
to use the genpd infrastructure?

Thanks,

       Arnd
