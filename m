Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E03E7CA2AF
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 10:53:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233015AbjJPIxA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 04:53:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232989AbjJPIwy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 04:52:54 -0400
Received: from sonic319-34.consmr.mail.bf2.yahoo.com (sonic319-34.consmr.mail.bf2.yahoo.com [74.6.131.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ED40DE
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 01:52:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1697446372; bh=jinnphZPwZ56tGk63LWNxoV3xg2MoudycaFzsfdtmKk=; h=Date:From:Reply-To:To:Subject:References:From:Subject:Reply-To; b=jeLP2P5OYBxjNZ9hxYtssKJAvh9mNT87Y30QwhIKexOGJBWOHxlOfLq9AnIvFqgS0PN5c7eF+R2KkR1j9MyFq1Jwx83YSBpZ3bRz+QPz9uvRy9VX9//ujdkSD8PN+9Q8ftqYeFJIl4b7NimONreGGGQOVdwroXvvuBY2nqcgSMpTIiDWx2xcKAg5xwli5g1DYyHsF8Cw6oX1kCGlpOwpqJGahwdiMQPhXLFPldYxBNiJGxFIcNeXvTrL58AqR6QuSliVJ/P/4QXfnk4n7HWYkVw0pbV63/VGjDlPzmSuOMcPLU6K4chAqWcMBVWtjbyd08PAm7KS2hw2500WNhLjag==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1697446372; bh=GTnCBt3yIBf3H7cK4Pi+RqqRDzi8O1yqaqlnJRqkI0X=; h=X-Sonic-MF:Date:From:To:Subject:From:Subject; b=p+2oQaclcj6u+xbFmUc3Fs9VJSKjXAOodRGxW8KzPW6kD1L64EuiRj7J9BGAAE5r2bqlDKcPzKRc4ivTyCQAqp60yzVcYIkqemN/n5OCT7rh/cnnqptgnGwh5JN4jeX57UQ3lMBGLYUSHPxJt1EMIiX45kjAUPpsD+Jn+j+3fyRXZCNwgiR075jECOVQb48pY7r3+9AdiUN7JXmLjZ5jY2ks405H79zT8eOLE4lJOIjkNOMJ9Q94r0HnAVYfEhG9XfmIsUljdWYJ/ZgTNXfTlPbS5GApv9gYLdzGhPmK1WF3zfRZZUj6jDr8RfsYzLve5dTAeoZDM/5cC7Y3oSgqtw==
X-YMail-OSG: w2Lar.sVM1lWEerHcPYOYict_UbBYjfJg_u3_SSwsGEvti1Np2OwMUzieFIEQ_o
 dLTc9Ge1nXiO5L3PWp.Fm4FJy9cMQtoKiRjJfnzM5NhsSkt2VvKIY_2XrscqzTUQNvBRxhA.kNqs
 _0xBzMzOvPxHp50RlJUA1ucLqxfHeV1dB_79FXkvndnblU.xWfaYub9kKetEmcJN7ZRnbMUb9OSi
 Wen69DeT.hwTuZC9VNy.kKkEORHXePNwwCte4AP0eR9GOuVIGbeAe8gNO7vvVXfV1oVX3gQK_nHG
 t3eGBbmM8Olvw.QyWU9.mFzXadEjct3Um0zpQW0qGuaOADHyVrwhrXoUijUi62w6RM4Q3V.JNOLY
 n311QockbZBgVTURD2MTTmgfT8WsCCtub.IexBL4Jfm_6VQvO7hGBg_hbiSMgASikAbGnX0FWKtq
 l2XmXVHifQZIKXnNnv24xmoRgW1JwtqH22eAC52hI.x7C8QUK2rNt5XCg.bsVMOGW9OZqWhnCfjX
 wWT3hfxrf4hqUZK00dgzcO8OvmTzDqkIOy_IAk24rniW5mKr8j9.dJOW9R8lYqqCMUuCg5Fw.Ri.
 y9FuMclGMjUS_.oHBUyRXdbcmCeOXbFdtau4PtEF9trynpfeoydlTpDHszlyjWns8Gq.aRobyOvt
 ErAJpCXMmtpUsQvKiHwxL93cJO.GxzP2r.RDTNJI2tQIr9IzxCemHO4.PiP.xlITddqtYu5vvfDJ
 jwk_3ylsAgs_1bhBf1_VXRMBt4_K2pVve22rl63KSuvUhzfqlAfjDvWCmg4Pa7xC0N.n.uikHEAG
 Glep.z10CsvIsUdHiNT6V9iYh.a1VbbxzNvbOJsLiL1B651Zsfp0U2VpA_1.YzcSXSmUnGGzO76_
 vxpYfHtqBQXL9UvLREnnRaaO9mTgQ1UQw7bfJq4IgWeYOutN0KYxh7GhBSK1yNiraha8vjexRwW.
 AlDyCD3AqTm2LoRCil4A0IRyQJA7d69nlEcEd0uM3WOpg.Nzs27l9zmBP8EA7ff8PWS5wa.RlcCF
 jJHD5m51BNz_svG.lA46uuithVy2CC6fvh7ysL0RrIu7q4ehVfJtPIUJSWEVD8Cu4fcH4asV6ZKg
 smmzgV2PRjRdGbW.tJp1yhCdCkH44asAp3yQhdPhEp5t71Q6ayYrgjJw75KwiNOU1CfITEKQCV19
 VSuMTa5SWhyW81YFyMnTen.BLkY2xuMcxBElmI0mPV5DyPwhfz1vC_2h1pnPqioBGm5BjfhGGsZG
 _DCdqq0dQTTctLkVC3atWxj_HWeWDCUTT.3bdLMnBpqAOqtwNIA_oO85so0IM8UQW5bmAzztcW5s
 xQ1Pgnk581lUTrBDjDDrHoH56pjBeKZh_6qD8KXXKOG8cnms08aZJfxT_t4jvqmk.Xt05bVNboiD
 rsYMyOabKAJa2HliHBOELoXli.cQ484ID1Ok.y_qmVC8O5RyLa630tzhH2o2evqbmWuIK3bgGhDx
 gR6lk5ENW4wfMCmqcLZR.MpVoO66fr3gFyE8BL6kfNYJLq6rmbxPD0opb5Cv_4BRUZh6gV6V62Fc
 JC40vB03YA8k94SPKaFDnYRnJds5HuxLqDgbqU.0v2sKDrGlEK2sAcqXCzcS.NoEOe6XW4zy5yO7
 ejtVx0IlyHQtYVs_1ew.Cp3U4fot_kKkjjBBr3Jb8sTYZ8CGbBk1HRjmqQtx9Pd1zCWP091Fpexb
 aGKm2H64EfL863NMVJSChqfiGfJ50WwAeJrEf5eXQfURPdm5XZdjZBgJTaq7mjjMenU3xFkAy.2X
 u36z4TGd1U8R0EAwReljsWNgG_GhfoQtFQq4HEqhmNcH6g5iWNzcNqwcYEobPGJel7pZtZcVM_oq
 tm3gaog6zToYhP9Z8pBgwk.mURJUrMFGm8Oha7.grqaVGERuIOXRLinxIk0oszDe3YYKS26YwebG
 ItlbT9KvhsG.0ifJWqlZKhJV.sBaGuWSZvCz9hlqqWxymv8BvZGQOpuh1CVjhpznnqfdVv_ecL3k
 5ti5VKvh4YmE_sL5VHKTg649Ez77PxkwRMwCkuDUTCnQ2FZ1xrxWBRxs_Q1TQ0GK5_mJgUP2QD6V
 salywTY1HROaAUPfLC_pz5hdvZeFc0T9TITRG6DT3lFZoGJLgo2S_IYyA.kLhrM5y3zJ8Bo4peDz
 0ZoLKSKFun8Azfj6HW28llctazraa5FxRIFzHxf8FGKrWy8h6E8Q5hflqhdWs
X-Sonic-MF: <dominiquevalon@pointpsas.com>
X-Sonic-ID: d5abe34a-0818-42fd-9b41-b250a0cb5a4d
Received: from sonic.gate.mail.ne1.yahoo.com by sonic319.consmr.mail.bf2.yahoo.com with HTTP; Mon, 16 Oct 2023 08:52:52 +0000
Date:   Mon, 16 Oct 2023 08:52:48 +0000 (UTC)
From:   Point P SAS <dominiquevalon@pointpsas.com>
Reply-To: dominiquevalon@pointpsas.com
To:     linux-kernel@vger.kernel.org
Message-ID: <1432142726.8532781.1697446368781@mail.yahoo.com>
Subject: purchase inquiry
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
References: <1432142726.8532781.1697446368781.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.21797 YMailNodin
X-Spam-Status: No, score=2.8 required=5.0 tests=BAYES_50,DEAR_SOMETHING,
        DKIM_SIGNED,DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  
Dear sir/Madam,
We are interested in your products.
Kindly send Your price list for Purchase order.
Best Regards,
Mr.Dominique Valon

Point P SAS
Address:12 Place DE L IRIS
92400 COURBEVOIE France
Ph.755531567
Siren:695680108
VAT number: FR73695680108
