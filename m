Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20B207FF6A2
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 17:46:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232137AbjK3Qpu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 11:45:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbjK3Qps (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 11:45:48 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D3CF1A4;
        Thu, 30 Nov 2023 08:45:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1701362749; x=1701967549; i=rwarsow@gmx.de;
        bh=B9k2q+vbaQ5LJUoIraLCmsvQD6achnJuAYo6Jr1VKxY=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject;
        b=g0IqENEdV2M3ePFWqk9OmZMwK66je4EsG1y+NFxV4Ncxegb4/ldNZ1l1IBitRHSp
         6zZpHAhxSMKbtCZxXdG/Ez3rhSarHiMhVuwdehdaSSCK6ONAVRqNVtI0KCkRUP9yi
         jD8oI20mXrPO/4F+36FDZeMsWdfS6xkSR+LpmwS9Y8RELsIBg8GsPzfIXjT20mt5k
         bLy/q0cJnTxveU6jAfJJ3U+mrIkC3Cbs0PaaYhBYzjTpCGCwy4FiVlM5TV11A8Dol
         ZC8ZZmTkkLsbYtb1X/mkrAyEWVuvMrw0JfuU8YsFO1CjxV+yqCiZQlHKcu8su3jEy
         03dkyQxyngmbtE0Vdw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.100.20] ([46.142.32.217]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MMGRA-1qsrTm3V7m-00JG2m; Thu, 30
 Nov 2023 17:45:48 +0100
Message-ID: <2764073e-73a6-4927-a7e2-163fa71d34e1@gmx.de>
Date:   Thu, 30 Nov 2023 17:45:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From:   Ronald Warsow <rwarsow@gmx.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
Content-Language: de-DE, en-US
Subject: Re: [PATCH 6.6 000/112] 6.6.4-rc1 review
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:eMYynn9vWiVxG6Dx3edEes1nw/MIJPCVgRoj20a30VoBSE7KOZq
 OThumm36kKni/FYJaL6R/FGT7vzBYMuZjxxIFC68LBS3zsHHcGtcvCBE3MEdZ44M3FNPB0G
 J/d4A1hJshcCPiPbqf8I5afXMqdw0jicMBBRFWazC5n/SeucE8sP3jUMf/fSsvWw17kvf6I
 AJk50Y/cQycCtZ+WpcQgQ==
UI-OutboundReport: notjunk:1;M01:P0:9nYgRrwXc8k=;t+Cha0gMzEz6NTYamw8jaTVUZn3
 Zn96Z7ffCIDagju3Fl0WhFLzt9z9thYTs1Hu51bTgk0QByWAtfIsPLF8DGqVSu2B9C6jMWgtO
 JABbtWwCsQkG8FcJFYFLtLamqm4p7nhlfM7UrKCLlpsOAE/VrKcGCZ5Nh/J51feVYWwsCRH42
 3SfqsBXYhQYUCHfY2/vyKlrPV8cvGtll3eRMq9UV39b4r+m5eJ1ov4KmRD0TbFRzr5TBMfzkb
 jGnrSlpNolYCLY7mDM5TKp+Ws/tJCn3ib8sR7XWbp4KXo670k64ICfQc/Hdgny4dRbE2sZUd6
 WWz4ytwjhJSf/0GEwNpO1/EjS6wAwm8k/qIGU7viJWgY/9ZGzeg+vMrZwqmLHX0Ly1DvkpJzx
 KkvIvau7FuB3if77imxBospYSZXoFHmj5Piyo/MhmUjwtuB5lB5+iJbR23ex3GW3HjPkPpivX
 b069L255vzq3Lnvy4YimzWdxR9mKqXpensi5SNkdhU8U8fc+TB4IfkNxhghPEoMvDOpXPV/Cz
 680wkVn2OTiwJigE3ZR3ylZRe4E55HuhvHd71rkEGcrDpSdkNWfc9GeUE6duXnVjjucwwFIAN
 sQAHuT/b1RFbjVOzfaMx2kP8ZduWx43AnFh3zOIsVWI+n0hcFiuCyJ1xUTOVkRDbTcQnxtuir
 IYlJwCqWkdniE1Mh/PS/eyHKJXCGCWLpfjYDNACg0kOooejMHFd7ZiX5wLqoIg8ATzsuurk44
 A3JRD3rE/gocmQhXe4V2UICVUo8gERhAaUHz+IvMvEeBwBB62/X9IFHVNaFLKsrOA/3kcAb1l
 i6kl0JVCpVYE9fp7x8nEyF1OimBYeT3dBcOCrh67dFvX+WjhrEaAjqE7MTyfOaos04Opf4Iit
 FBnqsnSjqE3xn5FlauEdbnJvpBTYxCm+P3A4JIynXU2lmWgbHhvpl9NMRY0SkfG6IxvcftBQJ
 l9RPLw==
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

6.6.4-rc1

compiles, boots and runs here on x86_64
(Intel Rocket Lake: i5-11400)

Thanks

Tested-by: Ronald Warsow <rwarsow@gmx.de>

