Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9186E797EA7
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 00:16:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234915AbjIGWQE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 18:16:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232200AbjIGWQD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 18:16:03 -0400
Received: from sonic309-27.consmr.mail.ne1.yahoo.com (sonic309-27.consmr.mail.ne1.yahoo.com [66.163.184.153])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D2761BC8
        for <linux-kernel@vger.kernel.org>; Thu,  7 Sep 2023 15:15:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1694124958; bh=J/5x2kgfb7frFT7pO9sXMZQVlE2CGHMqoGbkLL8bg/0=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=H/kcz90pIPy+7XgAvyTj1VwmyuGEkDXq22NkBgoA8oOd1H/vPUsYCfnqJlSuicK68CzcoUcABFD5QSW4hevj28LHQEd/gHLdTIy0UyHKozjNBtxjxePTEmITtmfZgUfU2Nl4pedKJehIAvDpOfwZD534eiqbdY5aIzDFJEzGWwqFxDMb+93uKJe83KQzf/LBPTv7YKdc3Y1E5BP4C02ImofbzjdKnqlrcYO4ZC5cZ/DOGPiuQty/RxLPPk8pJB+lT40QSe15qTNU9OXRLtoXvXfv4pdM2exrmQ2UBc6nNw1WjWUsHX8LrNL2sQjkZ55NQSTDUjNCxuXRJ60JtVF9JQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1694124958; bh=QidtF9NGrKmZX299zG4//Z69jmRHSoZDGdz9cAHWmhV=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=oPxsnI6FmeQAC359mFjt6OkLRHrIkcD972auBl9iiewI/iVLa05WRx6AlPsDW5QpeRg+7+F3kCPQOGH5Y8KrH0AAN7JbiKhUqaKLAwuxDAeQ8UAnTZwvrrp3RlS2Zlh87X/0iPjfi/hjuHfrEZLpe0x4Jmp2wk3fMBbka3T2gtkIAO1EJZ46/Yzp7KhNeemXJ1KHE0/IrNO0YbSUB6cBzYcKUq04eDxw9LY3+2nx421PDJ0GUSrq3Ym56RvbxCfyleB8RBtOFFaHH4L/ievY7usAtifNK//XW9g1sn+cLih+HDgaZvSDPlR1TVyPCz6RgU6bn0VHJZUepAdQKq5CmA==
X-YMail-OSG: zHoD0xEVM1kXLWLFTI_YITc5bQPhEzIFH2icw1c3SvCbOqB7snw1DuEH_n0SJxI
 3Qdh0yjViAiWPr4hr433aMWjMJCD7lWi.J1bD5TQH1aNL5.r0Ch3GfsSW9UmhVvGjPUPEcDeMWO_
 cDi3ty_SFNJKbr8RDuTHqYAcIXvo2U5Nuz1DMkyRBfVjEMIVTOQ2wDemnIRB.23ukWHoV.NqqMS0
 CA8AJoppKKes9Olow9EgRME_sf_ffMookcuU7sevIi04KPg7NEUrbEXX9iB7NmbCjf2C55o_YrOD
 hVoKB8DqvsGUvoiyMt.Cz0DGRHXzLpxS3IaSw1EokHrCaXzNiqe9YUnyZlEnuIKEN05pOlNEpXzO
 5WxEiGHdV8xpiIaEmwMUHZmyIQPrAr_CPRhZQZL5krcVtvGVs44bsEThm0qhke6wQIG3z5.iBW2H
 3Vo1TlGTwi4BDDYGUO_7ZiCrggeOE1Q1iSbyMuU0cIaMo5jsrt4Lfnq2LIUT3nBokncFv_Z6x_ac
 WAcVfCOpEZuORo9hlWnqp0aTJ3w4gWj7hetwNMFLh7KeJklh6kbgUFCcTfqsYy4dlhp0O7P_ACix
 fG9GsmcKYID5XMr9xZeslTuiX3i1C2eeEx7o2Lp3c3GiI0TN_KAsbJ8VLM_fkttHz0.jT7DflaFu
 ULMUgUPGw7tI4G8UqbwwbR516RAdZDFjU3.8ioiBLqXKzj4asTbK0T21t8jmweUp_3jdagrlCkqB
 nFIX545kHbvB41tOF8JmjxFDFl0G4St9Fp76MhX.wzgfOsQWqZQCrPkiAS.HjL1W91.PGg5mfekZ
 GDRRxoDeMk14Qea2kSrMFXzY6XxRdzBDngARZL.fbCKxQ2Jr33AxnonBTqZ2k7PYRhZoeRlL6ZCR
 Zu.JiFQBLiOQ7U7Auu1wFFrHkAbKw4HyeUHOLZkxRR6JJ6fcjb2Vtr3BeI3.l0PxRQdF6bHUSCe4
 Bpx3XPVUP6irYfMYG2F1FdTQclBRpZsPiKA7oIpajv7SvQWCNIucgvKk3YxiEoSNXoe4nLpldGvK
 _RHnzQx.ErMUpgu4m7azYY44MvT5CddNhxwBdAQGCHy6Cvor761epUWbJ.gKA2EvrgNggCBMjfZs
 JglHBx2sZDVsPucpeRqU8Q44oUulolg_FmcemkY3jrTwZQuDBI.bKXVgRjGmRjN6RWuD8LyPzfcc
 pCKxuX.RqhEyczNuDFWs6eEdO9DI8QXhu_nfU8BfPRoQvzDbwWg2UC70fdr3ZJumH8ySJpWfBKmo
 UVJnjrTk8_8PXXEQg2kVaX7dZzNUpcHTUY.Px4gVrEgOUwtGvxH6brc_6eFaN6DgFZu.qn6QQI2N
 0Y7B20bmwGUZVVNtjjnV2qI71E84.HUb_dg85.O5e_vBG7b5e5l7vlFno6CquulwT0d3zoTkHkjM
 w93RZQm5k_GS_aXLo0NH1cNZUTQ9qPsPBIXv8pL5_ONxyGoD7z_4LzMvfUxZnR22fsTuaQfHCb3v
 0eeYNJVz0697cnKO.Dcm7My_z3lRtvcbFYUBQHQMQZm4XaBj3i23d8lSdra1wQeOsM26T.xFHoTc
 hp2hrAuwdJt6SjsdU8rQfvauXsizC6aRojcqiUwUg3e8YsVB35yvfpzKzU0PZFBFk6rTe7u6dCoB
 iwaMTdapxkn53.jBnJpURyAJ5wKmauViEkLNPzLXoy6Dk84E_jJ98CQPnV0C5HS6fvmEvEyvb2mm
 f3TuE2kKXNlnwDT6_JJxK3dyXmB463s23QfIgIXvvSsqoL0uTwwVy.a9ijrLqpu4yZ67mEGnX60x
 ygmXH0K8_Rg5FWivX.9BnwHV.WY96s6oI7NhhLR9Npgfe0htPZIiY8iqKsEb6XicTAm4z.hCwRPe
 v7Qp2WIZeapIKBRJBpqU2adcdNyEE0oiOpy9zC3KtEXA__lE35n4008pvWcQ7MXajk63mjdamCGy
 N2.ZdXUnFbjU8_.u1Qd6y_GtJJZCbVi9xbb_tlKQr9DZm2X8sW3T8SC.WtGlJR_FtaorRZNxnU15
 2LXVbQ1nQkINIxR2tkyAbp9wj.CwDonVxLE_y3ZVjve0ipqI8wo8XJu0tlFLmK265Kw0GyVYPlrH
 hlPhP925yPqIdJRRG1rrGNlQYi9hUFPrBF.Hq03_zCYlCBQGhM_kDphqtc0Uq7n0kUyirdw2sLQ1
 TnJ4fIOX4FJ3nzj51K7sNuyxxPQ_dmKCe8FuflCG9iyjKhFgECPO_OlpiqS.DhvzfOUuBR2gGaD8
 VTTGb27Ii9gXDvKSYXP4IzR0tWiaYRrceUIs.0lBdyhtEIYIiUtyxtifXDS_ABDI0s_3MjwEDx5E
 rgrHyUpY-
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 356b21f4-d2e7-4440-b68b-2d3bf343415e
Received: from sonic.gate.mail.ne1.yahoo.com by sonic309.consmr.mail.ne1.yahoo.com with HTTP; Thu, 7 Sep 2023 22:15:58 +0000
Received: by hermes--production-bf1-865889d799-jmdc5 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 2fc523d470acf9bca79d8275a76c2794;
          Thu, 07 Sep 2023 22:15:56 +0000 (UTC)
Message-ID: <159ad121-e7e7-7d5a-c208-983c7a2b8d6e@schaufler-ca.com>
Date:   Thu, 7 Sep 2023 15:15:52 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v14 4/11] LSM: syscalls for current process attributes
Content-Language: en-US
To:     Paul Moore <paul@paul-moore.com>
Cc:     linux-security-module@vger.kernel.org, jmorris@namei.org,
        serge@hallyn.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, mic@digikod.net,
        Casey Schaufler <casey@schaufler-ca.com>
References: <20230828195802.135055-5-casey@schaufler-ca.com>
 <6bdfc1b73926b16fc4eea848f25275ed.paul@paul-moore.com>
 <fd1981c0-3f64-adb5-dece-a25494119992@schaufler-ca.com>
 <CAHC9VhT-GVq1D-AKMv_R3uKNm_iDV8uA3pB1ky5ScBnEdoPuvg@mail.gmail.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <CAHC9VhT-GVq1D-AKMv_R3uKNm_iDV8uA3pB1ky5ScBnEdoPuvg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.21763 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/7/2023 8:42 AM, Paul Moore wrote:
> ...
>> Yes. I have a fix ready. There are a couple other touch-ups, too.
> Great.  Since you are doing another revision, can you double check all
> of the patch subject lines to ensure you don't have any double spaces?
>  I see at least one, possibly two more.

Where do you see that? I'm not finding it.

