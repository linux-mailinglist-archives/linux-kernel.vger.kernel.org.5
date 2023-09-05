Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6510D792D0D
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 20:07:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236815AbjIESG5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 14:06:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239786AbjIESGl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 14:06:41 -0400
Received: from mail.toke.dk (mail.toke.dk [45.145.95.4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 835BEAD03;
        Tue,  5 Sep 2023 10:51:08 -0700 (PDT)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=toke.dk; s=20161023;
        t=1693935180; bh=WTMchHI/I01FA63jy+tW7Lr9wDkG0IlzCzQ1bjTKv0Q=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=snvxYENOsrnA5PcFPeetFZsdRATlMhb89i6ux0UyOmEgB1aTKq9UtocXlGGt1p13P
         gRGs9G5UmAf1zMNx3pY5TxjmcZxAq7m7iLFOxQCGLTgZopdgvPBeKyQdh4fPya7uW4
         Lbu2znNfL897SO0rxMmlSFobLVuwV4Rf3SnpnxEc7DrmsCIme0kLHhimP3+b4rnYqI
         8S8EGMWEYiJt4DJlC0ZnOxCpUcXkjKxmEsnd1M7eO7Z+RjMpMkypnbV0zyMkKhiDSC
         tI7oFyiuyV9xQI70P+f77b2IJHEuyM2Ya+ei2VKqsyQbdvWU0onvMD9EokbNYXthTE
         MQFX1oHflaDlg==
To:     Dongliang Mu <dzm91@hust.edu.cn>, Kalle Valo <kvalo@kernel.org>
Cc:     hust-os-kernel-patches@googlegroups.com,
        Dongliang Mu <dzm91@hust.edu.cn>,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] ath9k: clean up function ath9k_hif_usb_resume
In-Reply-To: <87r0ncq1hp.fsf@toke.dk>
References: <20230905013556.2595854-1-dzm91@hust.edu.cn>
 <87r0ncq1hp.fsf@toke.dk>
Date:   Tue, 05 Sep 2023 19:33:00 +0200
X-Clacks-Overhead: GNU Terry Pratchett
Message-ID: <87o7igpltf.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Toke H=C3=B8iland-J=C3=B8rgensen <toke@toke.dk> writes:

> Dongliang Mu <dzm91@hust.edu.cn> writes:
>
>> In ath9k_hif_usb_resume, the error handling code calls
>> ath9k_hif_usb_dealloc_urbs twice in different paths.
>>
>> To unify the error handling code, we move the else branch before
>> the if branch and drop one level of indentation of the if branch.
>>
>> In addition, move the ret variable at the end of variable declarations
>> to be reverse x-mas tree order.
>>
>> Note that this patch does not incur any functionability change.
>>
>> Signed-off-by: Dongliang Mu <dzm91@hust.edu.cn>
>
> So it seems this didn't make it to the lists; could you please try
> re-sending?

Never mind, it made it through now :)

-Toke
