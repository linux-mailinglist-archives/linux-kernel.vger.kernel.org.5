Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B26707684E0
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jul 2023 13:02:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229944AbjG3LCC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jul 2023 07:02:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229933AbjG3LB6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jul 2023 07:01:58 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6A421BD0
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jul 2023 04:01:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1690714908; x=1691319708; i=efault@gmx.de;
 bh=z0swlUCTVK6QVqYScu0DFM420HySwddGvjoYdXAMnjk=;
 h=X-UI-Sender-Class:Subject:From:To:Cc:Date:In-Reply-To:References;
 b=HQQ9tSjZz7zCilyRTqGE84pAedssR8w/msjyUOnFD/GxfnIHc62PJ+O2oBFdo4n1HDEPvi/
 OzhJfp0mFiDwOpjYgFDhCRdrPEM0VGS8WfR/lpwieuWutKIEzFQuL6ET93TSo+YPuMKHn1YZY
 08nMA4oavv5dqLiQGEav6BRPe0WotZ6bKG81djTzrwo6o2YrLeOQGeGmamYFnS9NS1gcVLBVs
 EiCOVVhazD37mu+rZPsE/F8ZyrLuh6n+H31VIsVam+C+zBtGEKF3+yInaiN7IgZPkvHzALnY8
 Kg3Cx5pfHgr4JibRZ9YQvOlPr7Frb0ZfMke9cNunIlY1aHlhnKYQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from homer.fritz.box ([185.221.149.208]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MQ5rO-1qCoeK1TvM-00M77g; Sun, 30
 Jul 2023 13:01:48 +0200
Message-ID: <eebd0293d415c75d5d8b14f490743e6ee50cf733.camel@gmx.de>
Subject: Re: arm64: perf test 26 rpi4 oops
From:   Mike Galbraith <efault@gmx.de>
To:     Will Deacon <will@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Date:   Sun, 30 Jul 2023 13:01:47 +0200
In-Reply-To: <069dd40aa71e634b414d07039d72467d051fb486.camel@gmx.de>
References: <b39c62d29a431b023e98959578ba87e96af0e030.camel@gmx.de>
         <20230728141852.GA21718@willie-the-truck>
         <069dd40aa71e634b414d07039d72467d051fb486.camel@gmx.de>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:vog+jVAsGj8xElDFFCBR7ja/yNfY//UdJso4GzjEc6HLzdu2Dqi
 8FQSbi8BwzV4ktJa0WGWE10Vld58G7dKvw4cb0grPh9oeG7+v4ehWMmPINfTbNfiJHt6dpW
 vtpvcG3JR7/VuDwynZk8qen0JKvNJcsspgurVv9QQdLOlCPl4zOF4lMGl39huivBwXIuTQ9
 u4LEKVmZM/Txttd7FPyzg==
UI-OutboundReport: notjunk:1;M01:P0:p/Mt9k1MU3Y=;2dGwSYN8JxDqJ9V7hKui0/VP7ci
 up4X9ZTBAa9leSo4MnnrJewFDixKRmHgm90SPuGXLov3YQ1OTAUo32nQOKZqOeQGUKoJ4aavo
 NSOw5pHU7NGiAA3HQBfbgXB0+LUXGmNXr4R+3SSLQA5qAHFErINSmxnaYy3hehXFdPlvZm16L
 WLyP208kQm5w01XhJ2e6zw/KRW1GwUl/BDReQEf2siQ9h5ffbcjnOj1CWcIATl9AE1h49JGl/
 KDfAAjN5vfxsEbTWK7yQueyP36h1zk2gZQxmnnTd8F6GO3y5WKByuWJDwq2vPCeAk6MR+ZmiE
 y5yVdcT0YKXkaeuU6FHBLJ13aSCXEX6zhotrE5F5t9lYIxAgt7qJI02obvFeg0j73610olHcf
 fpjVHO75iac4Zt7lTa4g6Xy2m3Qfv0QeK024KeGoEulyjd23IlHlm8FmRpyygzB6G6xsD/p8p
 u5q2TdDoHGJhTQf2NEPEzNPo2q6plcIKhEcfwBJtLx6n53Lo0uHlRs+lm2vF1tTKU+6qW3/+O
 TpwMgdi4rGjBB6aNP0ORCNNeZiWxxkSPi+Qhd6ljr5RHKGJPOPMfg4GAjWARrRbKYf7bIdkVR
 0udqbmJFg+7QhIZTQoTkTtXdyzOtUbvlJV9Ya0G5gcdGfqRJjT9lNJD+SS/F4+stNXTJYGv5I
 852f0Kh6fqjL+kmEVmK4WCxGabgzDXUXr1rFPqHf6O+F1doZ1nnHUIk6v+ypmitKWz0hzMN+t
 ae8nRKyKKs5DIoFRqNXKktjsfD4rfbl2hFzDJ1wFnGsRzawSN+/1fC2/hSjaDKl7dtEqymMEm
 bA6geNQQkwJUfkY6n7U0G/2hBjpSZqVANul9jNDy2c/l7y+syv3jo3UGrjpnZ3uL5/dfhNR63
 vdZlAVk/4I/MqDd+b72MLG5XqbWpRQ+qB/SXCgaOwtMQ6MpSlqaKtS3Utm45ybVonS2Gt9ERj
 ncLgmmNSq0SPr5WSuzcMcnmdNZw=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2023-07-30 at 07:54 +0200, Mike Galbraith wrote:
>
> 6.1.42 clean

Disregard, git bisect bad bad bad... just informed me that that is
simply not true :/
