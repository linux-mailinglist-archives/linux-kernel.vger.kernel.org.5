Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50CC075B1E1
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 16:59:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231922AbjGTO7z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 10:59:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232375AbjGTO7x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 10:59:53 -0400
Received: from sonic303-27.consmr.mail.ne1.yahoo.com (sonic303-27.consmr.mail.ne1.yahoo.com [66.163.188.153])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A016726B2
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 07:59:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1689865186; bh=TUc8NpO8iN72q9X9QslI5+6iDWFuyuxPTgt4Su2d5lo=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=l6eOGGUPkBiC9BlrCoyXTtT4GNIzTgu00u2kjHYZX2lZivkj7jVM7jnpZolwEIX4PY+Q7x2J92OOVNlMfn92qHO5C4J+CUCGA0rfmmZ01oTs4e4/1l2GrrfqVb169f3BS3SCLe50QIo9CiPBAZj2SP7BeWZoEWqObnEep+z7xcemYKDuXSsqruYTTMrvZm6VhhoCqepZ38YmX1EOQvGOFih/pXZZ8KNbjwrQ2g01kMme3YzZAYHUD777ZmrKbA0QMuD91uXzSnctxZe/dPS9fhmxkZV9/Vu6u/qC/0EDpS2f6S286AX2klT09tRlhH4XruhcIx8toAP+gkO5Fbof8A==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1689865186; bh=TWcGvt0YRlAnV4MpP0a2S3Eu9bqu3CGRNpxaTL1xq0W=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=AMyYp9EbEADgau5/Yp2fGnr80rRddU9gS/aEvHjcT5zTzzS6Yb6Q7Son2ES8LQXK4e9gGowIehPSPD8sGGbpCRh0Ff8BiBH/Nq0p1at2/6JF9DHSSTD2MyTOFmmmXYIC75pY1sB9jV55Edh/SG/n4sBTpn6SWhqI4C5F+++4oC/mJb/Lqniq+DquTmsyZ0FHSvxt5IPcRvaNmL252D4RqTWhkCFfKyK5av9HyJunZOA8GzMJItqzr5WnbswX3wYF48EW1UcoE/JMiBUW6uEXDCnyPSkl76LDwF3EiYaZsvp1RdpfTnnjkE/d8lWh0Q4qp5kNU6wAg0oi0MQjF8lNNA==
X-YMail-OSG: 7_Zt5moVM1nc2SJqP3KRf67gWPl3VDGMgHvDOK0PHZGsPd50vfObKK.y2fvHP4r
 VfbanAe4I4a4qS64ydD6LW6BnWRnRIvLkEUt7iOenTWKp_nR4liD0U7BvWMNx4Is5vBZpNyOLuDE
 .1bwIKhqHk1yaldWSarbH82jsxVLsWDmyJPSfi15wpcU0XsI2w96I0tiRdB4vv7YES_PgazYxcgy
 WsFVeJI6Wefe82w99.qZIVcPsy9rLtx9fnmUfGoen3Fzkyb241GNcMmdrPDBu0vFA32RzPHN9WMZ
 hY0VR4i5AyIulw5lvWBFF9EtOIagPPPvWUaELkPmKBVonzrwm7B26OsXrtywyO0IEiL38i.juNr8
 X3NRLvXT0znhos1lTNOjZ8Ubp2cJ8Ua4iyBVkHtLDifAxfOpRoJoBQD2k0nd_47MeYcZi1aS.Ubo
 Nz.c4KgMDZk.sH.8maDFOQZfPemDX0zFUsJ9A2L_pfUdfv7v5GflLbhvnNA025fZteuw0wPTMnBz
 wRV2SdJTeq3j0QVPt0F5_tY6o.7nyJKdZl7ndu0HxufWlU1LTVNfBGhnl.PYFIFonWoCrR7wK2T9
 Co90muLxIF_PEPG06XlZAeQ8EbtoYtI_nb2g62uNUWitisdKcHKhw95iyPTgtd_.fUM5_1nfBD6p
 oY56ok5gemzNma6FTDV6qpTJuCWdSIqTG56xii4yNDh2cjOOxHerM8DlQZcV15U3BzrWt_Q.g7w3
 KCJmQfPUWuezGfvypKRzROcWjJdC2te0zUSoxjTXcx.f.YPGeQjOcxagLFJ173HT4KBfGevQvXAm
 Jks8Y1W_vhdYzszORm6VWzPSnr28JQ0wkXDn5qppCiZyWb1FbpaOPBMbNaqaB2sNsliET9_Apf3Z
 e2dw_ooalrQFjsHf8dHNHz2vEigryX9.9vtqN9UcYxUc294hMwKf_qS2S8JC_FE7CYk.MWg_J7v_
 dPpC8ZmL_kUk2dZK7oVLGeQHeIRrkzkILbW3FitIMo7i10yDIn156iybLJ7XpW7mpNVlEJMvEETg
 J6OSBnkz4AtAd0pL4BJEloRDjwspjffSndlr9jZwr32NMBgOhqaLlcPUVsV982DxV9Q6bxv4ryOf
 1A_Rw.trBpX_Zkt4JqKPmjiH3j1uW4N.W97RCV4337inM1Hdi8igeN1iOUaiEt_lGY6uO5AFdYGz
 slwjf4UkPln_E5Mh8qKCA7wCVmy3UxSl3VdWaF6m.PpnEvrQiyHWGbTVbUfMjjy2MWtqOhmQr6GE
 QZGt7zX1YCrArPPYrfrTAP_GWbN4txvsQLBUQh6mpnsQP6DwjpVv3dkPgEeskNTUG90LBOsEn6gg
 Xv3YqDK93iKvGBWNPBxGlCbQP1fqoJAPoz23.e2u4SE2qWk7XN7Or9yJ_Mr22U9Xq78.X0lPfWSw
 e59RQMkkeZ_cBpw5i.E8rRRzuirsbiG2i7EtOeuagGqsL4we9uX7ZRLLqs7CLHyJ6g1Vo_1liDBi
 ezDP4sc5XWcJVMoTKb4VuIt5_lrdoTK8xIPEK.LZc4yJ_PXRuBtOeBJhoqvGekxsKyrrYtTAMSa7
 fzOZXd1Joc09qZ8NQOnqtZ8uidogD3G8LFxfpYNwcfWbswBKpXDlF_kv0RuBE3zTiwmPYA94j3El
 UXa65CZPhBVXMgUS.tozvjoqL5k7Y0jsG1ffkIcmLELAlGYcbTY4kUk.b1tWlp_FCqy1sEpJiwIU
 o_ITgLUHpJzlST6YhpAw_jGTZZW6ldrdsQZgHPkzx0bcCLA1b8zrvbqqVC7Myw_rwfDq4l6PDrB8
 zHGiyirbBh2199sUMMroDPmikOKq5rOssf_oL.eIadGbsGmVz0lyBYZo.bWS5e8gmFS_TCGNfKQi
 DI4E6MhyU1gPOTrt.TPW6ohp7tXAu4Bt7ayX8IFYUF9KSSOpmtvmkEd3Xgh_gfLBHJjvc.F3p0GP
 s43N5d6P8Izj3jwkWl942dMVlqx5JpcjC_JcbR5W_sPTQfRYXwj.e1ZWXJYdbQ6MkDHvE5gKiKR7
 4hsXTo4Qe4LykiItq1GpwuXFnePavpA0Z_5PtqXxreSh9o9TTuV6hxqIKeCtL5NURRm7i4tLETCt
 R71E5ZekebyV7qtwooO49CHA_FpkZS_MI3b2Kby0kEIXgtp9Oe.RLZjYf_cXVT_cr16M1XbamVWc
 BLiC_QvkKWte_rPEYQGVZxg0hPPe7B8Jqnxt0B8ynPJ2rR7jCpfHn.iGSb32GihBMUur9yCmuZEv
 Pu5y2a0dX8b9ExgtyWQ9VV53FkCYAPJrCy2fsEfMLfL7NzyCi9cdQ.7PrkbfCnSt0_DJRNR0Nly.
 WDnUA2A0L
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 26c82381-f707-475c-a65b-ca49a95c069e
Received: from sonic.gate.mail.ne1.yahoo.com by sonic303.consmr.mail.ne1.yahoo.com with HTTP; Thu, 20 Jul 2023 14:59:46 +0000
Received: by hermes--production-bf1-69c9587855-mrdtq (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID aa23250f1a7df050cf46978ec22c1b43;
          Thu, 20 Jul 2023 14:59:41 +0000 (UTC)
Message-ID: <d599f956-f6b8-fff6-7a70-7a2a77a68218@schaufler-ca.com>
Date:   Thu, 20 Jul 2023 07:59:38 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH RESEND] security: smack: smackfs: fix typo
 (lables->labels)
Content-Language: en-US
To:     gomba007@gmail.com, Paul Moore <paul@paul-moore.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Casey Schaufler <casey@schaufler-ca.com>
References: <20230720-smackfs-lables-fix-v1-1-7994a1f7e45a@gmail.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <20230720-smackfs-lables-fix-v1-1-7994a1f7e45a@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailer: WebService/1.1.21647 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/20/2023 3:45 AM, Tóth János via B4 Relay wrote:
> From: Tóth János <gomba007@gmail.com>
>
> Fix a spelling error in smakcfs.
>
> Signed-off-by: Tóth János <gomba007@gmail.com>

I have the original queued for inclusion.

> ---
>  security/smack/smackfs.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/security/smack/smackfs.c b/security/smack/smackfs.c
> index 5590eaad241b..2b79c30d4bb6 100644
> --- a/security/smack/smackfs.c
> +++ b/security/smack/smackfs.c
> @@ -114,7 +114,7 @@ struct smack_known *smack_syslog_label;
>   * SMACK_PTRACE_DEFAULT    regular smack ptrace rules (/proc based)
>   * SMACK_PTRACE_EXACT      labels must match, but can be overriden with
>   *			   CAP_SYS_PTRACE
> - * SMACK_PTRACE_DRACONIAN  lables must match, CAP_SYS_PTRACE has no effect
> + * SMACK_PTRACE_DRACONIAN  labels must match, CAP_SYS_PTRACE has no effect
>   */
>  int smack_ptrace_rule = SMACK_PTRACE_DEFAULT;
>  
>
> ---
> base-commit: 6995e2de6891c724bfeb2db33d7b87775f913ad1
> change-id: 20230706-smackfs-lables-fix-ac965c4c479f
>
> Best regards,
