Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 124F879AD91
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 01:40:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354156AbjIKVwi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 17:52:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235410AbjIKIe0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 04:34:26 -0400
X-Greylist: delayed 500 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 11 Sep 2023 01:34:20 PDT
Received: from fallback23.i.mail.ru (fallback23.i.mail.ru [79.137.243.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19735FB
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 01:34:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=inbox.ru; s=mail4;
        h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:From:Subject:Content-Type:Content-Transfer-Encoding:To:Cc; bh=aFjXvNvNIYSe445Iha33zHF5vS9lQUqhVa//k6eyLJI=;
        t=1694421260;x=1694511260; 
        b=tAy7SV827FDLbfEqM0CcKqigw4uwshVJF0zdpiMc/03ci1fbyt7xjEddiXYbDEzt1kf0Ptt1H/LyFB9gZVmI4LsZV9fD1VQeDWtwH5uBEHyOCxjIIXgIXq162nU9BCr3OHr40GFYZnMfSQu2twxsg2F2N7u3oPoB7NrcU3FNHym29Laelb8yTK5aWgqSm1Mnae1scWBrHsousUR5hSqTjx8Vm90kBZ3rSBBJvIuNeJH0tk0yO1buqb06/QgpjcyEM8bv0XMnp5f8BPNznCscIWOAuDPKWPd+RwMcXR0B2dKme/8toGwFeqIK8EmBYtJJ/FNhIHh8psbEZWqm8ZyNCA==;
Received: from [10.161.55.49] (port=41882 helo=smtpng1.i.mail.ru)
        by fallback23.i.mail.ru with esmtp (envelope-from <fido_max@inbox.ru>)
        id 1qfcF4-00AzBW-Rd
        for linux-kernel@vger.kernel.org; Mon, 11 Sep 2023 11:25:59 +0300
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=inbox.ru; s=mail4;
        h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:From:Subject:Content-Type:Content-Transfer-Encoding:To:Cc; bh=aFjXvNvNIYSe445Iha33zHF5vS9lQUqhVa//k6eyLJI=;
        t=1694420758;x=1694510758; 
        b=dFmQkS/W0K4VcMIf4m7wzDreg6Inb2xKUtL1yVhD9/CT0rwS65i5h/c6GH1S/5bsm/zt0bm8zHIHOubvMri/33g30HOcfSl794e2hYyeOkSLt6X5vL5yHmNOPZ27p+KdwOf11HlpWtSEVAbhQc++gzrE1U1A2f+XeF+0eoo0stdYHLT2QUnjZdDchz0ty3CwFAjA2KlBC0HiQFVewNAreyEkVpwGAPAebkfC7GA9vngALU77IsVMREx3r0JqW+EfvNV9q+coG4tVqcd00udPxXApYJDjO3Mqevo7uSFUAUHii5WTEiJVgg3841Cc7ONErBUHqvxQ2XvKgKD5DyN0KQ==;
Received: by smtpng1.m.smailru.net with esmtpa (envelope-from <fido_max@inbox.ru>)
        id 1qfcEp-0000eR-J6; Mon, 11 Sep 2023 11:25:44 +0300
Message-ID: <1021ad9a-a4b0-4496-af1e-ffc0e10f7f0e@inbox.ru>
Date:   Mon, 11 Sep 2023 11:25:42 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ASoC: dwc: fix typo in comment
To:     Myunguk Kim <mwkim@gaonchips.com>, alsa-devel@alsa-project.org
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Xingyu Wu <xingyu.wu@starfivetech.com>,
        =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
        linux-kernel@vger.kernel.org
References: <20230911064646.168181-1-mwkim@gaonchips.com>
Content-Language: en-US
From:   Maxim Kochetkov <fido_max@inbox.ru>
In-Reply-To: <20230911064646.168181-1-mwkim@gaonchips.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailru-Src: smtp
X-7564579A: 78E4E2B564C1792B
X-77F55803: 4F1203BC0FB41BD96E142CFC92DB15CDE87830E258C493C61F3CEBBE49E3D68C182A05F538085040F8C9146A5A1ABA0D5E62A7D9410C5E378A4989800397DB94D335C17525181FA7
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE73B44982FA5E78411EA1F7E6F0F101C67BD4B6F7A4D31EC0BCC500DACC3FED6E28638F802B75D45FF8AA50765F7900637D51A55327EA515C2EA1F7E6F0F101C6723150C8DA25C47586E58E00D9D99D84E1BDDB23E98D2D38BE5CCB53A13BC8DBA9396076998AD3CAD85727AE7CB97675020879F7C8C5043D14489FFFB0AA5F4BF176DF2183F8FC7C045A75973B56231AD8941B15DA834481FA18204E546F3947C4A7E03851CBA2956F6B57BC7E64490618DEB871D839B7333395957E7521B51C2DFABB839C843B9C08941B15DA834481F8AA50765F7900637028599BB38096F4F389733CBF5DBD5E9B5C8C57E37DE458B9E9CE733340B9D5F3BBE47FD9DD3FB595F5C1EE8F4F765FC72CEEB2601E22B093A03B725D353964B0B7D0EA88DDEDAC722CA9DD8327EE4930A3850AC1BE2E7358CCB3ED2A1DE2304C4224003CC83647689D4C264860C145E
X-C1DE0DAB: 0D63561A33F958A5676FB2530185834E7203E799C9FE97ACB85525A7B2F4A61FF87CCE6106E1FC07E67D4AC08A07B9B097AD43380FEE24CACB5012B2E24CD356
X-C8649E89: 1C3962B70DF3F0ADE00A9FD3E00BEEDF77DD89D51EBB7742D3581295AF09D3DF87807E0823442EA2ED31085941D9CD0AF7F820E7B07EA4CF6BF3D88D470D8F95FE247072695EBAF3D7040F432D1899D2843CC9BCFCE6CC70698455FC0CD9C182A44234FD4F46A843AAC10070AC2436FEC0B2DBCECF424D096E346BF9FA413E554C41F94D744909CEE921556F0E976A29E6EC0772259F8F8F8815B87D7EC76CB9
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojGCuXuOfYMcbQc6rQjw60fQ==
X-Mailru-Sender: 689FA8AB762F73930F533AC2B33E986B07510EC5C46C3CEB604D4930164896C898CC072019C18A892CA7F8C7C9492E1F2F5E575105D0B01ADBE2EF17B331888EEAB4BC95F72C04283CDA0F3B3F5B9367
X-Mras: Ok
X-7564579A: 646B95376F6C166E
X-77F55803: 6242723A09DB00B4595E58BBE635E2438CA7AFB115AC397BADE45817DBAED07E049FFFDB7839CE9E63861539D42AE1AE03D167D755DCF00D03503CE97D149ED9461330EC45EFC8C7
X-7FA49CB5: 0D63561A33F958A5D84AC36F5993EFE2E07987A99641D76D850678B8700216C3CACD7DF95DA8FC8BD5E8D9A59859A8B6C9DC896FBFA37178
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5xhPKz0ZEsZ5k6NOOPWz5QAiZSCXKGQRq3/7KxbCLSB2ESzQkaOXqCBFZPLWFrEGlV1shfWe2EVcxl5toh0c/aCGOghz/frdRhzMe95NxDFdaloFI76w+pL788HVlr4Efw==
X-Mailru-MI: C000000000000800
X-Mras: Ok
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11.09.2023 09:46, Myunguk Kim wrote:
> This fixes typo in comment
> 
> Signed-off-by: Myunguk Kim <mwkim@gaonchips.com>

Reviewed-by: Maxim Kochetkov <fido_max@inbox.ru>
