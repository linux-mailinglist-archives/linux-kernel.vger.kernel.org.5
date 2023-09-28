Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFD217B2611
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 21:46:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231945AbjI1Tqn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 15:46:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229864AbjI1Tql (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 15:46:41 -0400
Received: from sonic311-31.consmr.mail.ir2.yahoo.com (sonic311-31.consmr.mail.ir2.yahoo.com [77.238.176.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C5EF1A1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 12:46:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rocketmail.com; s=s2048; t=1695930397; bh=GqtWPlf0+EdaKOPCjj3TOJhuwiZnyx/TDix9hkr9Z/8=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=YA7amzUQ0NLCZdy7Q4med9reaOKVUF67+9ITO6frZmPFMZ6lqEc8wrfiHrtxYjkG7vuGZRQpyNsEsHtLkI5EW84CNstsz+WEqYvSPOOcSmzVQZAIx/Xurma4ygoqGByg4Ce3j+PZZndeHC/WG6fZIxVbt/w8Dun8aafehOqyrlzN+v4TIZ1jPqQYC2OJa0gAIAfjvPV9O4RdH0Q5b5w6wVKPaHAdh+b5whsICQhxeVo2QVZN5Fi59PAsZTRu47Rs2OQ9LIrvfH4yCew//OaXTpqYgZpgAe4GZKcaTs3LG1neKCtvSeBLEnHnI9tFh5xOcfAe0SvfXeR3n4/aoAQ1Uw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1695930397; bh=8HtTVwqvDs/3jW/wEjxEg/Fqav7L6Xh72MFHNKaRiqL=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=dbc1rbSkevwk7Zwopq8rggiAQqc9qz5tZ4WaMw5bKTt7dUrhN+wghLvVHeDlPSmdkipnPacKH46/zfL1VxQtgQ0dJXl39INDf4a4ACDX9RzIjTy8TVfvmKQf6yIoGLSIkbBQlhRnOgiIeMBICGOfmF56LIcxUUiktnbcsUTVJbgNrphLjQbO0MaexYflcXGkTDWEbj/bLlRj2QgXbjHNwRvHLp+bojF39IEWyCTGTfvgy8zjpql2nQVNuIxf3u/zL+Ax0hf7Xv1H1Mja9J8y/syGGfH5K4Cg/JH2GIaXP2z/+SYLn0WuIvPkX3wPRH3bU8l/0PzBWOh/aync3gMGsA==
X-YMail-OSG: QsjGRDAVM1mDX6TpKeaN.141ZQ7EHs8Dm.JW9uxiH67SDvJfB8wb.TrR8NwE_M6
 IzSWMxZoqq5Lsl3dFQGOcm1Nuj4g18UjU5wfhkuQXBS2Xf0XOknubipTEO4TsDSl9_eoGlMWH0gV
 ZxMiy2A2l4sQAdMHlmoIQb1nXdl0WBQ7QqYm.M7rdHq.i04ZRegW_oKdFpKZy_2sb4tWs.ZvuDKN
 6TzOR7tTHmb_IvZRUNv63m44jYv9ZQ13UgMu4MJTLPsGgIrr.OSmi8nAlopWHfcb3MSh0Ud85dY1
 Ow6tmSQcaxi0dSDsDJapyvjnZJxfD6BJTfIT4obxuZeSYAt5le2RIfhJ6xpjJ2cuhPZGjh2g8YqB
 73kEQQkDjiqCJ7UW0mG7jTYZRCgKQNVplzuV_kQZ_eOF_MijUlTUJLLrrAIAjdCbca.LFL9qklA3
 lyzOfghmemVEnhJ5uPWFV30aDbAYiGIr7HNqkU0TQ17GP1GD_cpnQVAvyScdfNrG9oIIOeQvRh_1
 y1Jwj5oLByzrOuBPOogXJFtTV_aeJ0.qgTwNlarsrYm8QBciFd7RCN16cC8vS0ENUfQKA6aBkrZm
 RdOLF8FH7Oxr2x2s4_I34xp589lpTlS2FYQKo20urI7a8svV9kjW7K9yUCxQQqd2iBzP8dbderjh
 FAkmzY6_8582EwbcIxJygOwwHIUpWegiGiQszgraSX.7XxUYlOhvq7knY05LCbBhLh9NgLeLd142
 iAiRDj8B_kH7ufzRLY2z2qr2Isyp.1ms9aFLs3TvOL_nnM39SrNPM7FofZ7IfM2fQ5jyCNjdiw.6
 6pm9Ygm1.jDAEpGlaFMBfOHuAadrGNjUcvb_dpQBX9LSCgLlNxhdarGrr6a3LDY_sC7Cfl7sGQNa
 d.BLqIoovJKNEFcP6itgJqTk_kxbSE.EiIXpfUqMr5UxfsxBgJ68Xp4fLUv72YE68UEnL84Honn.
 SKEjtbmWHVM7doGf7oE_wUHbQ0fh80Llukw8uqrL79w.xQv.R0MFuSOgFSdPDlieuUhHtlfPxv4a
 .7v66VnDbm5ea3cp5J6wqwG_G3EnmprBv_q3h5cFP73RYvqAgqvH95tpZY7igTeFv5ghtJgQYlUU
 8aQqjlmxrNCEqTOPH5w1nSCJtzS3sRlVSA7vvvKbeqpEEwlEboHzmox..LF.g0D2TTsrenlISwWG
 In2pDl8YWGGc7rTbDrjS0VMuMFFfLcMdv6M1RQ3pUIQJ8rxQI6oy0QEj3wpVO0.y5HozQkirvJr6
 b_bJ60dWXJrwh778Ls9uZMATKbHxfl.3pPs1.WFDPEAWZNUP5RxvdPqytMkavKdY5Fmh0SELiQzi
 smiQ.HxilPjWfGlAkiA9kBmUmI3DSqbxNWbCF.0KeB6xTLrFRJx5r.pUrKRaY0t2CXCKeGChmDcl
 0zFkEHbszp883uVAINJnMZ_eBP6ZJYF7qkYyR5WPcUB8.QXpcVYX6OhBDErPZqLronEdaHpa6Ez5
 1tUUjBBXLhL0UcOlvoIrRFsOeAz7OmLYFbZN6vwnGOc6FPpIWNfJYolA9ajcjHz_BC3nyP6.dN8J
 9BGCAgjyDJsJTJq5UFCexAnvyfrM1tgvoFI.lsUQJWQELGNztN90heUgQeLohkCM2GzNwCKKIPEw
 00ywDtrO.bYB5QNOBs82CFP.abf1B9Yk_VJBhQUw8BEiEy59hQPHGMjMyilQZMdjoJAG9EQJFjqu
 DsuTLhR3Ty9OaMXxmFtamID05rMEFq0bwzEHNEzYLucHRdrMZTm4QYUPWHQXnB7XQG6cdlqAA3Ed
 SQTpLcxBWOVnuKqjTRaZ7IbnknjaV1j3hPN_ZIsigdPgKvlKfxFvXX4_nv_xAmBOz3WUIcxvjvBR
 WiU3ej2f8bxrPLoJz.kHrzkpnpiTufjUexEJoR1yzOmDo2NIAPCVTClVsKBbZL313pkI9Ny4Ly1y
 LsWvpUg54Oc6dy9q7uin57_qTQXTC0bkslWD6egFC9kN9sYdPoUvPx1LVct0UIsiTLjWI3tZvV14
 .EHVMeb4VoubkOik8AAczaIh7WEaF9NOsH4xX.hhlR20jXW4gZDNK4N1fLrvA6y7.cajicO5zwZM
 gybrLBEPTU8i7CB0CFtF_2ke21DTnxl9bzQHYsyjVXMIxTW2agELCZXVq_nk08F0bFzKfCaBq7KD
 zrAX5gTdXLQWDKSllPBdpcjqRDAVACqmI_cKx2t26MgQwtOcZAJRRejrFMkzce9DbR9WPuyrQts0
 SnZqpHyhSl0s8m8Lq3Pq6UgOjlOl.pAFn9Udn_o4NEdMylDIqkIQxTWhCNViwWnS0mz847.szxzj
 PNdHSLMqZmFrNs7qd1vYGI.no3LprxJzGeA--
X-Sonic-MF: <jahau@rocketmail.com>
X-Sonic-ID: efb6f5b8-de3d-4ceb-b10c-7578db7508c9
Received: from sonic.gate.mail.ne1.yahoo.com by sonic311.consmr.mail.ir2.yahoo.com with HTTP; Thu, 28 Sep 2023 19:46:37 +0000
Received: by hermes--production-ir2-55db9d9d5-grc2d (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 143116114b029475daa3faba923ee518;
          Thu, 28 Sep 2023 19:46:34 +0000 (UTC)
Message-ID: <24162857-6863-d9eb-7fdf-e6c119e252d1@rocketmail.com>
Date:   Thu, 28 Sep 2023 21:46:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 3/5] power: supply: rt5033_charger: fix missing unlock
To:     Marion & Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Sebastian Reichel <sre@kernel.org>, Lee Jones <lee@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Yang Yingliang <yangyingliang@huawei.com>,
        Stephan Gerhold <stephan@gerhold.net>,
        Raymond Hackley <raymondhackley@protonmail.com>,
        Henrik Grimler <henrik@grimler.se>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht
References: <cover.1695844349.git.jahau@rocketmail.com>
 <e437e728317b6a2a860f7812f64a98146a27965e.1695844349.git.jahau@rocketmail.com>
 <89351ef6-ab81-c679-4432-cc44de9a91f1@wanadoo.fr>
Content-Language: en-US
From:   Jakob Hauser <jahau@rocketmail.com>
In-Reply-To: <89351ef6-ab81-c679-4432-cc44de9a91f1@wanadoo.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
X-Mailer: WebService/1.1.21797 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQ2hyaXN0b3BoZSwNCg0KT24gMjguMDkuMjMgMDc6MjMsIE1hcmlvbiAmIENocmlzdG9w
aGUgSkFJTExFVCB3cm90ZToNCj4gT2ssIGJ1dCB3aHkgbm90IGFscmVhZHkgaW4gcGF0Y2gg
IzE/DQoNClRoYW5rcyBmb3IgeW91ciBoaW50cyBhYm91dCB0aGUgbWlzc2luZyAidW5sb2Nr
InMuIEFuZCBzb3JyeSBmb3IgY2F1c2luZyANCnlvdSBleHRyYSB3b3JrIGJ5IGhhdmluZyB0
aGUgZml4IGluIGEgc2VwYXJhdGUgcGF0Y2guDQoNClRoZSBwYXRjaCB5b3UgcmVmZXIgdG8g
KCJwb3dlcjogc3VwcGx5OiBydDUwMzNfY2hhcmdlcjogQWRkIGNhYmxlIA0KZGV0ZWN0aW9u
IGFuZCBVU0IgT1RHIHN1cHBseSIpIGhhcyBpdHMgb3duIGhpc3RvcnkuIEl0IHdhcyBhbHJl
YWR5IA0KYXBwbGllZCBvbmNlLCBzaG93ZWQgdXAgaW4gbGludXgtbmV4dCwgY2F1c2VkIHNv
bWUgaXNzdWVzLCB3YXMgdGhlcmVmb3JlIA0KcmVtb3ZlZCBhZ2Fpbi4gSW4gdGhlIG1lYW50
aW1lLCBzb21lIGZpeGVzIHdlcmUgcHJvdmlkZWQgYnkgZGlmZmVyZW50IA0KY29udHJpYnV0
b3JzLg0KDQpUaGlzIHNlcmllcyBhY3R1YWxseSB0cmllcyB0byBhcHBseSB0aGF0IHBhdGNo
IGFnYWluLCBhY2NvbXBhbmllZCBieSB0d28gDQpmaXhlcyDigJMgYW5kIHR3byBhZGRpdGlv
bmFsIGNsZWFuLXVwIHBhdGNoZXMuIEkgYWRkZWQgdGhlIGZpeGVzIHBhdGNoZXMgDQphcy1p
cywgYWxzbyB0byBjcmVkaXQgdGhlIGNvbnRyaWJ1dG9ycy4NCg0KUG9zc2libHkgdGhlIGNv
dmVyIHNoZWV0IG9mIHRoZSBzZXJpZXMgd2FzIGEgYml0IHRvbyB0aGluIGFib3V0IHRoYXQg
DQpoaXN0b3J5Lg0KDQpLaW5kIHJlZ2FyZHMsDQpKYWtvYg0K
