Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF6407D5678
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 17:31:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234890AbjJXPa6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 11:30:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234828AbjJXPal (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 11:30:41 -0400
Received: from sonic302-27.consmr.mail.ne1.yahoo.com (sonic302-27.consmr.mail.ne1.yahoo.com [66.163.186.153])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D3C81FD2
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 08:30:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1698161408; bh=/YWm8GWX2383RfzFLFlBBduZ0aqXcPqlJQ3Z3PAB/jk=; h=Date:Subject:To:References:From:In-Reply-To:From:Subject:Reply-To; b=oRrVD3MghqUvCPNNVDqxY5gD7/iZWJ5beBwVmbM46N6KeIOs98QvthAVhKEqsIkclvk2wr1RXcfh1Gr3Q9EPSBj8NdS4zZGcW9UCm5m1ulk8NLBRrAIHp+CVVALv42qCeuxR5m5DS0HrmwFxH+tX60aoePLSiKoJ0LtvYlVA03XZ4WYcRC4WsA/A5zYl7N5CcjC3dHDXaeztY6QqgwVUiiclG33TY2ZpLFZZPr9ZW9UcSVGNeRHEEmKbpeOgAEqshiva/kMjcAduiUARZTkk+jHai9o3jSo8NunwUuun3vGLXJ9W+Kcv6LQsU9AzT0aMWiZEOnCGA3OC+8k+opl/KA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1698161408; bh=CkIOfqZ9TC1VkyJ7eKh3XTtlD8DmK8bQcnLdZ7gE9j3=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=difXLLaq92rU/B3K+Bjmm2EFmg4IhMPFDeOBmICWrC4kLTaWJwpOmdJArLY/vgFDiaELYzA1wT6ByMn1aliB+dUL1vDBj/UgYwEbEiUr5WV8C9nt85x0TLFmAa1AoOy+TQpgngTEItfGFH+Uz2Ir+ASn4e09OoB7qsntaTkR1tpMNtf9j+2Ki4dyCU9u24ehTcEr9jonmsGS+XZaM0ZKvni/VuVTHxfEhiE45eVmjSgJ5pfa3l9I6YiEZWXZJbs9b8bAA78VatUKaZV7iuoLxvgIuNFFu+QFDPLGnpJkqB89Y0bqNSvpkUjNVcwvUS8TEruyVDdrz2JTKiEijrTFxg==
X-YMail-OSG: B4ESFpwVM1kBZ6lSz8rkkaXhskytnfYU40elwEwgBiLLQZujXONemP5xHi72sOt
 ai7ZWBC8CJCZVw8MUfjwqrM7kujN_pfUkWR6Zt67bdR01U2nvtGsfaVBSHrZ3316B7mYc_IWswMN
 ggHnj0tqoBGKOUm238BxaeXRIZIb7Y7remZYF16w4dTf3g00wwfa2o7bO3bJshxzTdIS3n9bnr.Y
 zgkhl26mNCNNJd3ifh46QkCxH2cLgOiYrq2fzGI_CIAgPedHsCSRCBCJR.A9QobIPbYIKTUepx2b
 9NEoDaq8c2EBUA3_SQsOU4SFDtvkREnQ4S5km3n6P8XHEgosm5ElHGSMq7hCXF6v7CW2ESUMpuGV
 kqyif8dqRE8x2kXdMZl4unuwbhGdQxYyMjWeleyaDZ75r.J9sq.70lsmOeAsTJlJk7bTqWvAns5j
 9N3jGik3y_WrUhae2XxGtXPdwfspZN07uA8BrhekX1GU9CrdMY5bexy_y0bflZmRczNgzVOuxkEd
 N.JRSeGCb0bXiqurRm7wx0ukYjWlSSrITGsjSX4DiB8iNVbwY7s.8mrH0A9qXB1zuGpr3aFqKER_
 YsAXJ3Dub.E36nnjS01zDrGsXR8iyer5Lo39Wlr6IQxmxQkScTB8CP.G8xlCHJK7foJJZkrm2ITG
 k5EsS2oKD1n_jGS2fMv.HmDboZqQzb3EbOMSBeLTUcbTLoZsxAFFzz8W7.FJKHvxoocaPs6Mm..J
 1NWrMNKhhSsALI1rgzQI4YVkCAOesI21bAt5LIw7qDpQbKjheooVsnGc7.ZQ2zk9FgJwP841XowD
 LHYXSgzJB.fPth.0GIf8VY8h.DzdmdVSRwJuE0RbY9hcPAep2EFO4hPDKdkG4N1n049FAKQTNIHE
 _mOkgno3yu7MdYLZ9Vafa_p1Aurny4ey2tihyVujaKTKUJWySHsgvJh9vuUPUIMEcx7tGGiDRmsm
 L9qDppwVWYk64CutoaIO4W8BSJRbkD7DNVyUTYGIWLmLtsye8mYBTr4Qpm1kktuQn6ntqNDW1tX.
 aPEk22pkRLczeUR0LLCuK7xguidMOmuwyom39hoQr93cFpQg6RnB7b0fC9Wz.1aAoJA.lXOGAdKp
 MDqq0k6h8JCoXYC8oY.k.oFiKzPhaqG2akyD2NZoeddH0QwuMRDKM5YBJrTupWtdU64rWwl0ev4l
 5EySje8tQ.6JwdR1rEeXav9YhHq1DndSBnHS_sFLl5Fvyo1hp1ij6dpHltSamh1sdGwF3p8LD9UX
 VrcCEKAOFcLIpnQO24mVN9VlR8DHuN6orecrrTDxPZ4EhtMyZ9u4_vKTPzso_wgzUmX25PAbhxrn
 gkr3yR0Oqrv8fyOxKXqTpr7jmeGB7HY5xi0llqq892PQWtSG24g.sM4pn8qomh5awh_UkBYqUr7n
 FJmTPO5ygl39LKxOBgO.8AUELQZXuDED7yCozPTL2o1vp0IXWH9zJzHOGpPD.drvVlQbGhBR4BU3
 teZ.UGUYmCT12Ai1SlvovfEPawwJl5DTGxSZRfuuiLZJWayFO0W6s_F2sl8W3LOXd1i_XbEx6VIt
 X_nSzWMDPuzwpnqGbweg_fQq2gWezXFsxqNm0mY_LEu.UyjbmCbDQDSh8uph0Ui6fC19B9UC89ns
 4_q6PUJxpnkDn0OHDZmaOJ0Yj0cF4AYaUga8QttzcCcBp2azGw3jkZC8u12c5phBZnzfeiAJKJqM
 Ul8H2Qezo2QN888BOZF1CqhlltfHFAECwvsGWOOj44Mff71H6inqBAI9zrdqeW3PMsPYyqRdbWDb
 WHWVZyM88odTnXedhvC8uaAUN_knRzbg5qveYAtspLDjA5dcotfI9tvJn6HonYV1iC.ewiopqRA7
 ..oT.N.99eAxxayy0qggE8iAYwCuBOXcZxAUmUT517W8cWADDOtUUT8Y4VDJkg36s_Dw5Y8WFSil
 7PwsD5GVd2R.ojPy.fm1DL5PAP6IwySw0Mt3Y7tEI0d5jJkuVcSzM5RTPW41d50dZMcXHFrNrpy.
 mIB0rKUB18MHUyqQ3AivrRQuJHxz2Xk9Sdg4XHmozlxE9hF9BLUf6t.tIRDxEYAxYgW27qPjrQ5U
 Wd63CeBd70IjSp8Z38CmiuAYOOTg3usrE8MkoGDmdiunuNm45dx6jzp_7uN81VcYaKd.M8oI7igV
 UwfUmmtRbZb3tSSFtYZxWHAz1rojkTe5HxGVL1nLpWtn12nKKt6OFbKSPaJtvJCD2kn3cWdxXz.D
 9ODnAeiXLD.YGqz7ntz8UGXx6K.yjOTZT7MEg8Uk22BDRSeQvNVgJa_SgAcfpqZERieIhgSddOJx
 LSqt7JB01NQ--
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: b51fecd6-b267-4256-b431-c807c318f436
Received: from sonic.gate.mail.ne1.yahoo.com by sonic302.consmr.mail.ne1.yahoo.com with HTTP; Tue, 24 Oct 2023 15:30:08 +0000
Received: by hermes--production-ne1-68668bc7f7-tcb7m (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 5fc5461d31a49f2849dcb731ecf23d84;
          Tue, 24 Oct 2023 15:30:03 +0000 (UTC)
Message-ID: <b307ec62-7cfd-4a58-88ef-ea549c64e75e@schaufler-ca.com>
Date:   Tue, 24 Oct 2023 08:30:00 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/4] vduse: Add LSM hooks to check Virtio device type
Content-Language: en-US
To:     Maxime Coquelin <maxime.coquelin@redhat.com>, mst@redhat.com,
        jasowang@redhat.com, xuanzhuo@linux.alibaba.com,
        paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com,
        stephen.smalley.work@gmail.com, eparis@parisplace.org,
        xieyongji@bytedance.com, virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        david.marchand@redhat.com, lulu@redhat.com,
        Casey Schaufler <casey@schaufler-ca.com>
References: <20231020155819.24000-1-maxime.coquelin@redhat.com>
 <20231020155819.24000-5-maxime.coquelin@redhat.com>
 <c8f189e6-c79b-429a-ab36-2193bb68e3e9@schaufler-ca.com>
 <923f87a1-1871-479e-832e-db67b5ae87fd@redhat.com>
 <64626db9-e37a-4c65-a455-fc3985382216@schaufler-ca.com>
 <7524dee3-7c48-4864-8182-1b166b0f6faa@redhat.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <7524dee3-7c48-4864-8182-1b166b0f6faa@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.21797 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/24/2023 2:49 AM, Maxime Coquelin wrote:
>
>
> On 10/23/23 17:13, Casey Schaufler wrote:
>> On 10/23/2023 12:28 AM, Maxime Coquelin wrote:
>>>
>>>
>>> On 10/21/23 00:20, Casey Schaufler wrote:
>>>> On 10/20/2023 8:58 AM, Maxime Coquelin wrote:
>>>>> This patch introduces LSM hooks for devices creation,
>>>>> destruction and opening operations, checking the
>>>>> application is allowed to perform these operations for
>>>>> the Virtio device type.
>>>>
>>>> Why do you think that there needs to be a special LSM check for virtio
>>>> devices? What can't existing device attributes be used?
>>>
>>> Michael asked for a way for SELinux to allow/prevent the creation of
>>> some types of devices [0].
>>>
>>> A device is created using ioctl() on VDUSE control chardev. Its type is
>>> specified via a field in the structure passed in argument.
>>>
>>> I didn't see other way than adding dedicated LSM hooks to achieve this,
>>> but it is possible that their is a better way to do it?
>>
>> At the very least the hook should be made more general, and I'd have to
>> see a proposal before commenting on that. security_dev_destroy(dev)
>> might
>> be a better approach. If there's reason to control destruction of vduse
>> devices it's reasonable to assume that there are other devices with the
>> same or similar properties.
>
> VDUSE is different from other devices as the device is actually
> implemented by the user-space application, so this is very specific in
> my opinion.

This is hardly unique. If you're implementing the device
in user-space you may well be able to implement the desired
controls there.

>
>>
>> Since SELinux is your target use case, can you explain why you can't
>> create SELinux policy to enforce the restrictions you're after? I
>> believe
>> (but can be proven wrong, of course) that SELinux has mechanism for
>> dealing
>> with controls on ioctls.
>>
>
> I am not aware of such mechanism to deal with ioctl(), if you have a
> pointer that would be welcome.

security/selinux/hooks.c

>
> Thanks,
> Maxime
>
>>
>>>
>>> Thanks,
>>> Maxime
>>>
>>> [0]:
>>> https://lore.kernel.org/all/20230829130430-mutt-send-email-mst@kernel.org/
>>>
>>>
>>
>
