Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C32F07D0FC7
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 14:42:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377332AbjJTMmg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 08:42:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376956AbjJTMmd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 08:42:33 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE9AD18F
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 05:42:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1697805743; x=1698410543; i=efault@gmx.de;
        bh=nwAFHYEisQWi9qMsde0QUmjgG8BSkXeqrufobxY2tAI=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:Date:In-Reply-To:
         References;
        b=LSKy2yd7NZFvctG4qhFYBGSr5EH3RaWYsrtl+fKU8mnaoDIJfMPf6e9RvwPh9d3f
         pjBoha0/54HGZ8EMZDdWlIA9B6DddFZ5y9VOpGszQt5kF6QwHQiAwllqRqP8R47P0
         pOpaZosqStJRdHUxkBIgF5F7jpt5oPBERwuyy51Omo6R6OLbzMMLkOo2oM/0cSdww
         K5xlj2P0GlhO4KDbi+mai0wkOuu9Ml+eSlPxigaC7WdopVTX26N2pmXnbiE89NPMT
         QpttBlhxmdyCwc2PS32VCdg8hzLAmK3O+xa+TxBg0HnWs+u2sFh7UabhFp7iBvrCb
         uZFeBocATcRPSvIuQA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from homer.fritz.box ([185.221.149.246]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MKKYx-1rENaD459j-00LjUX; Fri, 20
 Oct 2023 14:42:23 +0200
Message-ID: <7a818250a8f36476f13b57a172fdb1ab23645edc.camel@gmx.de>
Subject: Re: Runtime overhead of PREEMPT_DYNAMIC
From:   Mike Galbraith <efault@gmx.de>
To:     ema@debian.org, linux-kernel@vger.kernel.org
Cc:     Michal Hocko <mhocko@suse.com>
Date:   Fri, 20 Oct 2023 14:42:22 +0200
In-Reply-To: <ZTJFA_Ac6nWawIHb@ariel>
References: <ZTJFA_Ac6nWawIHb@ariel>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:/VhL3IM3X6vILeJgMbTo4WuranOOMyeE+JMYCLDfTfiaQV4o/bb
 9EzRon3OJtlMHsw4cufWCjgqA+21x6OcDHhKpuqvWxh/hjCPm44nR6O/OaNMuYEx27DQr2h
 OHI/zRowKGGV53B05HMLRn2CpURLUMibfHSN7bIipHMobO4NgqYPcQ9LTZVyc8NdoM3ys1Q
 5FeaZXmfHdSyWgJAMw1ig==
UI-OutboundReport: notjunk:1;M01:P0:ExrZ2xdOZRY=;v2Tzo4pSN9LaEr/iW73HEqS4SO0
 +Sk0I2EqbYGUe0K0khtn2kaxpckw3eTNv0Kg8gUxicrcouX+6tVsr3j3VjunepjuT9Bzg2jOm
 UULgMb0U2xmD/4ocro8VeGf3EfpI0MGUAxhrJ9thojgDiUNu/+Et5Jj2GGsUxFVnWfPhaL1e0
 8dN77D3mZlb4nIgtQks+3CZoHJQzXXJXnM82QxEUsB03Id182zKa/yb8evI0HHFZwoQ4JqK7b
 IuPXaUU0VhYaR7LqRChrwkmkS4WBfNIG8yywKLhaOtJ9Sb7OEEjFo/jEUg9lh2B6fSKLO0UKT
 CdEsYPHIHXAxI02mm07mtkkQl48TX+ZPwh9SjNiouCs8+6sY4zPDvb7pTnmN1RgYJCm4ULpY0
 Dzf5lQY+0ByhGW8KZrZJDB7wbx57sh6iWiNnt5oji72UHQI5pkANEVx03+1+b9qvPoBGRTppQ
 2wUkSQ43vzdPbTohJqdYwE7fKTVpbxKZcN8BMmVwCQXHprLx8NAd/EzrkpjOHKsg3eM8HC4uT
 rfirsiWfrwV81HPAtDacaQLCnrf8AKSbCLETioLPuTp4Z601u7sZ8K0Z1yb20qYDEeAm88IUH
 ny64RASEyXVN3fJxnrRbm4aQAenWAjrZjXGcY4DxbkTbza5jY9GA7jNMCcnkLyymw+96HjdxO
 LK04Kn5afw1tsw6Fc/9i0XfsfCb1ehpdRNSQZCjMUs2Hjh3oky5lBQLuBf3ngbWbYOrp02Duv
 GecEQP2dZcDHpu99rAeFUkZM+9aq/TYx8U6ZT59HT2Jm/5cbOhMm+Glfp2LcdNVkIB1aEViHl
 BGzC/Mr07zgnp0jvvbjYhPnZIVpSG95+YMT4G3+aowkgrX4yox84E89vRjXxgN2GRHDLeg3cq
 oBq6BD8Nn6iTKtvgv/eG1rJGpe0Rurou7mID+Z2/gD4/I6h//Gj1ZnLFo6RpuWCh+Ad1Kz4Lc
 AiKV4bMim9JS+JeZYhKbmcMSIdc=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2023-10-20 at 11:14 +0200, Emanuele Rocca wrote:
>
> Results of the tbench benchmark:
>
> - PREEMPT_DYNAMIC=3Dn Throughput 3831.82 MB/sec
> - PREEMPT_DYNAMIC=3Dy Throughput 3006.54 MB/sec
> - 20% performance degradation with PREEMPT_DYNAMIC
>
> All the tests above were performed using Linux 6.5.6 on a AMD Ryzen 7 37=
00X
> 8-Core CPU.
>
> Could someone please confirm whether the approach above seems sane and p=
erhaps
> try and reproduce the results?

FWIW I can't reproduce anything like those crazy tbench numbers.  It's
neither free nor crazy expensive here.  It's kinda hard to imagine the
author's mailbox surviving submission day were it _that_ horrid, surely
something is amiss.

i7-4790 (quad+smt)                            avg         cmdline
6.5.8-voluntary 3685.08 3679.93 3704.98   3689.99  1.000
6.5.8-dynamic   3571.62 3568.61 3550.55   3563.59   .965
                3651.37 3599.87 3615.18   3622.14   .981  preempt=3Dnone
                3459.58 3514.09 3539.88   3504.51   .949  preempt=3Dfull

voluntary (my usual)
CONFIG_PREEMPT_VOLUNTARY_BUILD=3Dy
# CONFIG_PREEMPT_NONE is not set
CONFIG_PREEMPT_VOLUNTARY=3Dy
# CONFIG_PREEMPT is not set
# CONFIG_PREEMPT_DYNAMIC is not set

dynamic (same config, just flip dynamic switch)
CONFIG_PREEMPT_BUILD=3Dy
# CONFIG_PREEMPT_NONE is not set
CONFIG_PREEMPT_VOLUNTARY=3Dy
# CONFIG_PREEMPT is not set
CONFIG_PREEMPT_COUNT=3Dy
CONFIG_PREEMPTION=3Dy
CONFIG_PREEMPT_DYNAMIC=3Dy



