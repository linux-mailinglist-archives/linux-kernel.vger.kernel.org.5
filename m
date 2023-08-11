Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5113B778646
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 05:53:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233293AbjHKDxb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 23:53:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233394AbjHKDx2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 23:53:28 -0400
Received: from sonic308-11.consmr.mail.gq1.yahoo.com (sonic308-11.consmr.mail.gq1.yahoo.com [98.137.68.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC9A830D7
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 20:53:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=att.net; s=s1024; t=1691726000; bh=9amaImanC7wmD7zWEs2r0P2ogPLDW5tnz9w758kttq8=; h=Date:Subject:From:To:Cc:References:In-Reply-To:From:Subject:Reply-To; b=BEZOlgo0CoexePSg6OqBgaYrvhU4uxI3v77/4183fV6NMLCIHa2vo5BnGivKxiYMrPMW7hcWUrns77opNcMHo4jY/ufuv5sBW/aphP1ZP7ACiXCkeLN4cOMnDqujeljycOo+UegE6hPPrw/5hRtbZVmhEqdwLJ94h4N1pPJbGuU=
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1691726000; bh=F6/sVHgVtOatwKT61oc4J8nYufmCbZYWWABMZK5WJl+=; h=X-Sonic-MF:Date:Subject:From:To:From:Subject; b=P0LxYbcKB8499YdGZBQOgSFbVfYhhGmk2ZjjtHkIGrXjnSin6jR+K1LGJGA/Iw8s4r58+RGKYhHd4zNv+fa6CnAI1lT00GIIYNJfYW0zS3+Bs/hnG/u1HP4XlBcZhL61DXFAG222YVQVf4T1YPDgZaWrAV1UPu1o8HoUaETK1odC5YNOFLfVmveU0j/xRoDbB8cI8bjQPWGUcjlWQiLNY4O7FJAJwJQnvHwDe0eMUVwq0r+5HMfHvtCEMNyoE12oSKMq/5iqsWdkOB+oiGimXkmy7Ra1EHKCWZA7C/3rSKWo2kzhKueulbegCAaBOxZIEU/3W5E5vCn4leJX0W0fnw==
X-YMail-OSG: astknmAVM1nqTjkbYvrpdWsuhIJZBUPF088SCvCjlicxL93QhLEOEiP7kP_kgos
 m5uFSqoRSP9u1UpOj7ppEh3PFWVyABW1zhTsWyvrEXcLviWqOnhjdosvlfjXdQwZ0pTnyCqz62um
 hEhBOfoARV01Ls2n2QBaDOpTMUhj0igfUP06yycNalt_JBjl4WyjkAO4O9Ok5eT_d.91xDnow7Xd
 rYGsoFmLFTs0kILOmKaYomTtEVrFf.AE9uOhr2kkEVzoxR2w_SinArMk1tjcFQalyDN6OYXss5WT
 ORwaJmWMo.mjth349DnBUZa4ljl7vKFIXeq7OzvHlNlNs6cSuBguROYU6gB.MxcjMNfouiKsgb2f
 3Hg9IZpzazXhUnBEPueykiKXRRH4AYOQlupVfb0r.Rr0zwr6qK8tzkGXrDWEa9OgHJ69QlnYPR6X
 vGaq2mxi2Jr6jojR7uEwLs7hdntNJ_UHoWkTXiHScKSlKcrq32yHdwas5NFXOk1E6l2An.ERtJ0n
 vNCqJr6uFbmWko0M5_3SHRs22wVSqJ9ZIaLmkxhprbabgiyJyY1Kh6KtJ3RY9RF.3X6mlNZi8MFH
 Uo92plSOtWbTAoVEA55scFLscdWkh6iUmVjAsnarvUIJAk6GhMoQoaxdlV5zujlp8_PVoADJo_uz
 ophfPBdnzbpkCI.hEA18IcZcxUbqeywUxY1tinp6_LsaFegkduv8Y8v93EkJKAjBkiHg99Gm5_0Z
 UIzdZ7vKVgh.5A_ewoLeO_7tlGvR71qY34qGceXrUbNUARH5jTpPZqqQZKASqtZAyQz5nRt3mErJ
 eBV7K1xVAOquLwoOLNrk5aRfy2rO54QLtyBEv8OVHXvtefoIxQjfLWwbUczeD8Bt_94.HQSJy5wI
 vrq4cbTeSGpBoOkMc9vrUrPJOCu0Q6p.R4FV6c2vrjuAUMlccwR8wFgARqZeBd1wJm0_am44YQx_
 tRE5v7tFIFttf9UU7iy69WEv9vyJzgmPqgwo8fu2mLyS99YNtF0.gc57Y3VR8H3LuXtuqydsJjLa
 WotfNRbJy9p1pOpo.lRw1cc6vZfBic2elSuVvoI7p9vg9Ahx73wz3dth2LTGRqop2vzBU2CEVVKO
 GEHlsGS5_Bjyx8xrxTe7zEo02mIyGwbyZ1hqzoVvAy8cmuyJ_P73DBGxzWc2eZWI6xZiavNbBYTd
 3tvOAPEDEqJUm3X.x_vCdCrjLduwNVu4P2Gjz6t.mM.Joadjn4Xia2zs8BS7MXfAqV5zd2lQJuSj
 1CmDdI_f6yztTyoNCPrsrHkaskh.w62VuZKNHSa.10fX8xY8i0w5QVOXHxYxuCHeFoqnw467gp1e
 d6uQAAREj_krT4eJeiv6HgJsgiiJrW2Z3OzG.6UZV8fTV_EsjuVmPTEXWuO7neDRlQnVwZswWKS9
 Bpg3MU4U6Khd.QhLj5je7AD0dJ.AThYAaBp7jAwWtnUFoqWTOxMMsLE4xx1N2QXVkU_fSNpV16BL
 Sue8qwjcBu6daVCodG3uCgs0N.amFHFwYWeWroggW4e_XUKzZzq7t2XUgSmw0faDeBFNfyU3AeqQ
 UteeBsi65oGTEUuvoRl_qBqUoyzHnyG5WOnuEg4mrgswSit2DymLhwHYZF2PEamxArzIeZV4jL50
 x1mUnbK7BXasevUjjpG1.kQ52cgnNW0dlOnUSSCBm9jbfL1LoVSPvs4H14UsP9zhht02BFAHxmXK
 NaTvdGmvkgz6RFyvQfPWese5VzJhyA5ZrQ7asNxX9DUoCzcSuUzKvoSmFOBtw7SkiEAOE4_3PkdC
 AqGDW3fa9.zX77c1mUlzeEtlGoXi8eUiYOypYPT3ryGpG.EK.mvzWgDY0vkaXRUFhtMRmSAi6NK.
 ssoDaf5DMr0Ym2xTtX.ZbzInBPS4KvfhtZick2si6o_7YcJebtRMjwoOxAau9r4TsvT8NfCr4rjY
 bUgD7u39u01kwi2Tnn9mHj9h49egoBFDEJWKnQU6HIlpkMG06eG2tfuH6kZhGY_3MD9Pjei5BtEu
 2OHZDngpWaq_Ed3IkE2a2yBk53tsVRMdoIXqOxQ4CQJxnizoN5nm2Um0T.oLaeoIPSThKkZQN6hJ
 odddMtmHMZTYwxn6McS4wH_DFLoQUZZ6O33Yb8MAfYjZHVDuTSsvOb6EYy1dXJ7YPrQl_MHXV3t.
 o6kTqjyYxah6yG7hmUitV4ZUkifn9veAegWVsmqBFYilzvFVBUucErtxLt3Sm2wqkVfB6JwfqC1_
 ULVtxwunHgkJl3jAKDCjC5esoIan138VAnR5__eXp3el2bzT5qRY4
X-Sonic-MF: <lesrhorer@att.net>
X-Sonic-ID: 8b3df8b4-4638-4e2f-842a-9e870de4cdd2
Received: from sonic.gate.mail.ne1.yahoo.com by sonic308.consmr.mail.gq1.yahoo.com with HTTP; Fri, 11 Aug 2023 03:53:20 +0000
Received: by hermes--production-bf1-865889d799-cgv22 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID e412af30481515cc8d9f8bb7690bba07;
          Fri, 11 Aug 2023 03:53:14 +0000 (UTC)
Message-ID: <38f29379-4a8b-3cb0-c5dc-7cb4c8246fa4@att.net>
Date:   Thu, 10 Aug 2023 22:53:07 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: Majordomo not working
Content-Language: en-US
From:   Leslie Rhorer <lesrhorer@att.net>
To:     Luis Chamberlain <mcgrof@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        pmladek@suse.com
Cc:     linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org
References: <Y9BIU5SGOS6YEdSh@bombadil.infradead.org>
 <06bc7efa-c486-f995-a73c-3f1dd6a5ce64@att.net>
In-Reply-To: <06bc7efa-c486-f995-a73c-3f1dd6a5ce64@att.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Mailer: WebService/1.1.21695 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

	Update: I finally managed to get a message through from my AT&T address 
to the linux-modules list.  I am not certain what the issue was before 
this.  I am still not sure what the issue is with the Majordomo, however.

On 8/10/2023 10:48 PM, Leslie Rhorer wrote:
>      I know this is not exactly the right place to post this, but I am 
> at a complete loss what else to do.  Please forgive me, but I cannot get 
> the Majordomo at vger.kernel.org to respond to me.  I have tried 
> everything of which I can think, but the Majordomo will not recognize 
> when I send it the authorization command in order to try and include my 
> siliconventures.net address in the linux-modules mailing list.  My 
> att.net address is supposed to already be a member of the list, but 
> whenever I send to the linux-modules list from mt AT&T address, the 
> message bounces.
> 
>      Thus , I seem to be having two issues.  The more immediate is I 
> cannot get any messages through to where they need to go, both to the 
> Majordomo and to the linux-modules list.  The more important long term 
> issue is I am having a problem with the NIC card on one of my Debian 
> Linux servers.
