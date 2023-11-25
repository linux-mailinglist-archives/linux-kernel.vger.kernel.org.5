Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C51D97F8CCF
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Nov 2023 18:34:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229782AbjKYReM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Nov 2023 12:34:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229697AbjKYReK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Nov 2023 12:34:10 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA0C3D5;
        Sat, 25 Nov 2023 09:34:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1700933654; x=1701538454; i=rwarsow@gmx.de;
        bh=haGKNqR3CS1ywRA/jRS8sHTUfbnLG05vnDHeLpdThc4=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject;
        b=JoCQ99DkSkpg5rlqQ6Am3tJiTvKzEKnjFsGkHMVSOeD+Bu5R7wIAZzlL/tp+XgZK
         6PfKaxDp3l75nDHQZqq0kkmPHrEAro5Smkeo/7m21Ey94cbXGpot63dJOCKp8fZie
         kD4Pt6MRzHSKhs0WjvGRHJfstARKthq7Q3ardwvt7lRrjrW7yLTECjTQ9OgxG39Dt
         elT4DZRK8ZEPo8YhnNHslo7Z5+sr/iBRSBJTgLkVT9BAX9nyPO5qy3ePQU212S9k2
         hdkJIqI1KLjcj8r8Wp+kTZTm1FMSTjyvSCO/eSDyXe9Ofwt/X65Eyx8IuRs7mfYyG
         Mifle3XeSORiqetOHw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.100.20] ([46.142.35.101]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MaJ3t-1qmLIJ25ED-00WDxi; Sat, 25
 Nov 2023 18:34:14 +0100
Message-ID: <3aad11bb-ae74-48e2-b318-69ad17a189bb@gmx.de>
Date:   Sat, 25 Nov 2023 18:34:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From:   Ronald Warsow <rwarsow@gmx.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
Content-Language: de-DE, en-US
Subject: Re: [PATCH 6.6 000/528] 6.6.3-rc2 review
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:LIHao+cHJVaJ2PAJ5+LqTMwcqhbBud6zKVb99J3cHqfGn7BwCGH
 TX2n0wWB3SU6KQ0SehmBx0QvSgHPuziEkBmSPAMVhUbCpIROl0yyfaYqekV991oUq2UuPbs
 G1RyyyctF5Fp3eteUEXzanGLYCaYFvkTisbNSsXlcLAlF4cS/DE3hweMtMPH0J442tuPXic
 QzXylkJ+y0PC8RpsTOQmw==
UI-OutboundReport: notjunk:1;M01:P0:sGYjw28L1Fo=;7KGmd3QaSW3UURH9WtTec7OmIlc
 L7sQj42kFVUONR0fHQXJVKuBpfwL9hYOXtiykjTpLketrPZ+/H8WGp//WghQa+yaeEsnI+d5U
 awx7s8Ziq9C4EzCG97Uoh9sCuLMmV4QEm9/WuaJNbIyrRU/+4EGaUyd7ADdjyO6y/DATK6hhK
 ABvd2AjOE0XhUE59Bvy4BP3igsg52RLUH6vOuf3njG0vWs0BkHmiTTNePwRm5OUGzkhfkbDtq
 8Lge0/YOBz4giw1zp6YeOx+U77Ev88jxX4pZ+jJc2rPWKxtTGupFq8NN9V3RFbNZGN+NY5llu
 tzmd1X68cbaDTMbmkDsFmurJ79OT6TzIO0MtzW+t3JV8AXP+L/GMAnGbYBfhX9Of8rPVnLcUn
 a734wD/LPg95z1zFg6gqVejqBloReChlZyAf42y3TXKj2oMpytb9zgzWOZEb2D7t27Wq6hjEm
 D6NLnnAB1I2w25WJ0qe+6XI5LaSKXT5swocevYikqMSrbkW9uIYrMxd8MbA/SMN60dYmENHDl
 IhRmi+KiBN5FdXbgcMiFaIBnDDiZ+nhEMnH2FXdOEb2tX45+Srqtq5Q112XhTRw7dbVWH6pmN
 13hLamFXpiEWjQ2TJIJoWvhm45maqDsTRBXrw+cpGotHBNVZIMNlhftdP20pcCtWBKq/MjQdB
 tpb4hja2gPqfYL72H6Yw0ZVJzFyIItlAmIWVr0LLp9abTPbOpp+YBvvkqwdIejj+KUuC8Uaqf
 Usrk2p9RZE2knObswUhZLTyBNIuLaFsl9g3sfpsmKy21ZVeKcTsEySEKV7fupvGlFS3KmO18k
 HWZW5MMiPGn1iMBsU38DlnYXnABpDT2/Uudd8BWPcD6sgW4M6puu0ukmKB48MoerDVi9yN+Ym
 xjAyfIjrEdTn6o7VuWt3+ZhXGknaUsoeDn3sgz2FYFOtTiu2jdvHuD9jt92GY13K/r5v5+R9/
 v9GdFXgt2sba5OYnR8jztH2viTA=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg

6.6.3-rc2

compiles, boots and runs[1] here on x86_64
(Intel Rocket Lake: i5-11400)

Thanks

[1]
a vbox crash (known bug):
https://www.virtualbox.org/ticket/21898

Tested-by: Ronald Warsow <rwarsow@gmx.de>

