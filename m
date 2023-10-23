Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23F667D3A73
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 17:13:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231575AbjJWPNr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 11:13:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjJWPNp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 11:13:45 -0400
Received: from sonic306-27.consmr.mail.ne1.yahoo.com (sonic306-27.consmr.mail.ne1.yahoo.com [66.163.189.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9CC5F9
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 08:13:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1698074023; bh=5qhVm0qgr8MH691SK66XJk00Hxsjalx43/T/nxE11RE=; h=Date:Subject:To:References:From:In-Reply-To:From:Subject:Reply-To; b=eIMVqvXCK0N6enOdR3XYdaij+4lApowWtvpfSolkqo6niG1w3GuRDrnZXRYu2EmyosncbxXJONkYIrI8CGTLxPunP07yBauVcuKHYwYzaAH60XH7B5xgmGY/fZiXrJ7aW9ylgD4aA/+3Iz4vdYyUutrtnrozf/Jgky63arzVmd7DUdil4F5BG4vwmdoFvfowWXorMaicn8IF22xeoIuMsDnDb0WY+NWhX3eXqERM3TyWQbwSy4nOwnzHHx2ZSt6RlRT9DnRK+duKMIIMTEEHCOcP87YJIrN8n69Q8aUrYpWWeOnkDYY7A2sQi5wCoIoGxuOiuS3+TLzIqputSDIgdQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1698074023; bh=OaJlbcPRdhgb16Vxj8vBgx/z56oKzG59epzMgdrnPPK=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=ZS5lJatzliNW+xOxGVTQVU3VNWMMrOjl30HLcBo4zgU/K5JWHSesSDUUv7JSnFoCIuPLTD7bJkOyuTMHYel0cyhF90dmqA/bz0fVC7w8V8d3jmxU+AplBL8WPEqUxbnThMagTY1R6Tz4lOw4IgoCu92b3OiyTmbELtztHXrUwa59nwBNhFWvk3UgMZ7H0dM8LSg6KVos+3oQxx/mmFa5iIHg9SjTQfVtgeegr56ONLEoC+0bwZ6s8aHfBh5426h5xz+/lsOhcX0RjT2/RlakjjY2GUZqzHjkCoQjiNUedBdQjBMMdDSUHtrLpY3nbjHkkOCtjkKAL0LZzi9ozN9DbQ==
X-YMail-OSG: CWBLw44VM1nf33uQEfb5bmH6sn7LKTfUX_Zz6p2tdKu2BCeBfDnhjEtyXFu9tTZ
 INuvp51.xhDXrHRjZ8zS7rHCdZaZ9f4U9mRO543iHR9gDkzsbijT1aoNuFprr38ne5yWz9b8GPUp
 G6RB0SiByS9A4wcCvplNnVcb_xyQDcDjfUKdpJJlnjUnu2ONjembyT1z5xea4l1UNbyq0g8Ipcvi
 7qtVDQTuYT3yOztcsd95uhxdmp40iY1Jovtzy7LsILZkFL4aILM1RFKD4ESs9df4Rg.V2QyrjNRX
 vVlS2eRZYvt8AvsT0yXGfT.PMuGRff3NAxLKLKQ.XztolTXTs0F2hpQoC9.1eD3ujRV8vIVx5WyJ
 3zHGzJONe42UhKC8p0A3YJQjrpGnjxXUi_4_G2RS6jHFixHva_Cjo383j9N84tYzhaYvl5LF5y6I
 tcGopQq1NKZTKwi8g.YCxcnK2HTV4V5vHpbcDXeb0cOmMRIAf_QOK_c1bfDmW2n8TzRZJEA_zcLO
 J_iCJWZk7IZ0GZMVpP5yFIARWA.vNu4J9F.fimHvVX4fgrwAwjtl9RHtcZQnGATeuxO4HKe_gH0w
 cNO4mpcSjXCIahpC84IA0RbRGBih_Y8L71uF3.I5Wrq_wCHkIaZkPK7Q_2wK3ZrW0beGvyJPPTKZ
 Z3PgtyCFRuHj6Swu4bzOYSkaRWcLMvY1e9WQKQS8IGPEPsvM7EGJWoMPHIqdHD4VhifdAecVokec
 Js8hkbSu3EdsGse94rg1o5Uz0Lj.mjS0eKD991Q807VGmgDPZk6RzPxsXqTWLiVCOebBgUpmGXt9
 Vp7xSp7aQyuZQ4QMfiX8gpFygfV4c43OMGmmST9TLFCXKJITSt3sqig5KE4rs1JwzmKBKt52ktO4
 i_qGAf6DLrEvybANwnQsLtk6TQKejF9yrajdgX7sZQVHRajuhg2mImI.21WFAbxWnklckFYLl9Ck
 J2X0OxzmTAKb8GiFkxqjjy5zY0yWGaKTpcDW2o.LMA76xh5ZF2E8.8XYgLNtwZuOIdeeN.8jZW_X
 A_GQkgzaI7qexP2WaynyyqhY3R1w9iTuCMaP0n8IiNSTbvCu9wPvBtO2bXd4r9kIXj9nHxwwc.GT
 EhTsT.D.HGL8f2z56LWSfzh5NRmHBSbRXTGGAeGenrxtMbPeAPQXnQHVftkWfA7g0.XiWFrtg7S3
 1HRLBVsQNVi2iPNgAcOPa4m8aIGZmSrUgkRFFxzxHL28EisTRC2utWp.zTIVUH4EYvNP3fHUCizL
 m8H5TnMFhBP.4gvpr2z9JsDLZ.Hpiy4MrhMzi.K1Z5da7ZqZgWBBMECHSpAaJxdakU2f6Zr2ug37
 iR2HsGf8cxj.EwW.GznGZIiSIwBDzxFo3vCeYMRBl50pVRCEOYE2hzn0_aSOYu7C1dND4Tb4hjgE
 AgA0O4FBQLg993a0h0pzkwEpT_HetVvbZ5qC_d7zPfutzEitaM3r_AG04vta45CxtUIFm99rJNyt
 2i2gCIy8wreoLz3R4OUfFBF.X1aBOdXqnjw_zMrfCfvEcEY99GomnsKokrTLjWHCMxOfcwZh2nz3
 JNCh_JLDpgakNH3lyoH_xeU0fAWJe_dg4U2tZhI.28OQAOX5iIBsuc3HVjB8m_nICk6N_qpGKhOL
 4._AZ7JfdKEwP5D19M7Tp8BL19Ni7uxNDQ.ayKgN9dI1S0wWGAfVFbr03tQ8CBH2ZxVlJljDlu8g
 ChM8zzKaTcP4gELWwEwJoKQu9HRPyvMr4.lTT572rcixr6ggO87byZPy4_fjesStsn4ykb1IqNlw
 gYl.z9m7rV2sxAWp.NVvYFEqMHMO57vt26qZn1Ce3LmLsJnEN5l89byUMhbKK_grfrr61FPUZWly
 ViSzc08YI_4tyDDizDfjpj32H7cwzL18am8syU63aZnS72_4L8XUgzlUlNpWIBNhtpA3tx5lEdgu
 PJ_CM81tRGX0EI6tjlT3ne1jINNqOZwTGuUuopImu3vBwZPp.xAENw3hPTPZV9EdHPJ4K3TlVkUx
 eAkzYrni9qXD4KIG3W.WHH2mMTIpgZNrSxV1bX.D4AeAKvRWXP4J49i.0uytCyhYYyXJ_LED1W4b
 1EfZPNtyGwxy7DDjdgi2uf.Pi5t1VmPVYIHMLWUv6f6WC5p9TWr71ADWb7mckh9BNOXhG6I1_w0i
 zOcp5n0byV7u_FNC5jARO.JzXbCTcXVdbBSnFdjpLkLToNKYkitIgtI571xRkNn5qwLAa8i7bn29
 89.PcdiEqIotFuLewpOhulTmoTJUCs13s1pdK5qFpJyyQhWZwMU9_JbspwhR0mFZxwPVqfI5RPUc
 CknMKcw--
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 5c4d3800-39da-4bf1-8665-b40081fd39d8
Received: from sonic.gate.mail.ne1.yahoo.com by sonic306.consmr.mail.ne1.yahoo.com with HTTP; Mon, 23 Oct 2023 15:13:43 +0000
Received: by hermes--production-ne1-68668bc7f7-pg4xv (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 6749c8cefbdd6387e1e81113019a3174;
          Mon, 23 Oct 2023 15:13:38 +0000 (UTC)
Message-ID: <64626db9-e37a-4c65-a455-fc3985382216@schaufler-ca.com>
Date:   Mon, 23 Oct 2023 08:13:35 -0700
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
From:   Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <923f87a1-1871-479e-832e-db67b5ae87fd@redhat.com>
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

On 10/23/2023 12:28 AM, Maxime Coquelin wrote:
>
>
> On 10/21/23 00:20, Casey Schaufler wrote:
>> On 10/20/2023 8:58 AM, Maxime Coquelin wrote:
>>> This patch introduces LSM hooks for devices creation,
>>> destruction and opening operations, checking the
>>> application is allowed to perform these operations for
>>> the Virtio device type.
>>
>> Why do you think that there needs to be a special LSM check for virtio
>> devices? What can't existing device attributes be used?
>
> Michael asked for a way for SELinux to allow/prevent the creation of
> some types of devices [0].
>
> A device is created using ioctl() on VDUSE control chardev. Its type is
> specified via a field in the structure passed in argument.
>
> I didn't see other way than adding dedicated LSM hooks to achieve this,
> but it is possible that their is a better way to do it?

At the very least the hook should be made more general, and I'd have to
see a proposal before commenting on that. security_dev_destroy(dev) might
be a better approach. If there's reason to control destruction of vduse
devices it's reasonable to assume that there are other devices with the
same or similar properties.

Since SELinux is your target use case, can you explain why you can't
create SELinux policy to enforce the restrictions you're after? I believe
(but can be proven wrong, of course) that SELinux has mechanism for dealing
with controls on ioctls.


>
> Thanks,
> Maxime
>
> [0]:
> https://lore.kernel.org/all/20230829130430-mutt-send-email-mst@kernel.org/
>
