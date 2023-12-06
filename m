Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3E2A806A45
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 10:03:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346670AbjLFJCx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 04:02:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377144AbjLFJCu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 04:02:50 -0500
Received: from m12.mail.163.com (m12.mail.163.com [220.181.12.216])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C345DD62;
        Wed,  6 Dec 2023 01:02:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=Content-Type:From:Mime-Version:Subject:Date:
        Message-Id; bh=bSXEOtYvTrwoUoXd1xh88uMJIjGpO/qF5Wv13PfY9Rs=; b=c
        gP78LhuN7x6FQstyZBJFesSlH0rZOkb8F6XwZdNye+SDrAo+BA/+Jt7UMHCgoSE1
        gPVi888MJxHGdM2MmK7F7c4+hZMQbebG3ZSXxoHMNH/JkSqGxKvzGY+O/u9IsVkT
        KaUC9SG6usfmg2b9Tcz+MuNRYa32SOZ9gnV4qgz73o=
Received: from smtpclient.apple (unknown [223.104.132.42])
        by zwqz-smtp-mta-g4-3 (Coremail) with SMTP id _____wAHD6+kOHBlnYMHDA--.36351S2;
        Wed, 06 Dec 2023 17:02:30 +0800 (CST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Hao Ge <gehao618@163.com>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] fs/namei: Don't update atime when some errors occur in get_link
Date:   Wed, 6 Dec 2023 17:02:18 +0800
Message-Id: <C295D5E9-ED04-48AD-AA4F-70803429D289@163.com>
References: <20231205-endstadium-teich-d8d0bc900e08@brauner>
Cc:     Hao Ge <gehao@kylinos.cn>, viro@zeniv.linux.org.uk,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20231205-endstadium-teich-d8d0bc900e08@brauner>
To:     Christian Brauner <brauner@kernel.org>
X-Mailer: iPhone Mail (21A360)
X-CM-TRANSID: _____wAHD6+kOHBlnYMHDA--.36351S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7XFyxWryfGr13Zw43Cr17Wrg_yoW3Xrg_uF
        sY9a1vkw13JrW5A39rWF4Fyrs0qa93Wr1UJ3s8K3WUZF43X3ZxJr1rGayfArnrX39rKa4r
        X3Wjvw1qqw13CjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU0nvtJUUUUU==
X-Originating-IP: [223.104.132.42]
X-CM-SenderInfo: 5jhkt0qwryqiywtou0bp/xS2Bgho+Flc67gXv7QABs1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_BL,
        RCVD_IN_MSPIKE_L4,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Dec 5, 2023, at 19:07, Christian Brauner <brauner@kernel.org> wrote:
>=20
> =EF=BB=BFOn Tue, Dec 05, 2023 at 03:17:33PM +0800, Hao Ge wrote:
>> Perhaps we have some errors occur(like security),then we don't update
>> atime,because we didn't actually access it
>>=20
>> Signed-off-by: Hao Ge <gehao@kylinos.cn>
>> ---
>=20
> We didn't follow the link but we accessed it. I guess it's not completey
> clear what's correct here so I'd just leave it as is.
Hi brauner
Thank your for your reply.
I just thought of a situation that user access a link failed due to some err=
or(like permission issue),maybe report some error to user, actually user don=
=E2=80=99t get anything,but atime still update.
Maybe your are right,after all,we still tried to visit.
Thanks
Best Regards=20
Hao=

