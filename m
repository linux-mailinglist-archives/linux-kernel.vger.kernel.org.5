Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E29C57B9E0C
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 16:01:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232792AbjJEN7R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 09:59:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232011AbjJEN5K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 09:57:10 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C8A02570E
        for <linux-kernel@vger.kernel.org>; Thu,  5 Oct 2023 04:47:07 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id 3f1490d57ef6-d865c441a54so937301276.1
        for <linux-kernel@vger.kernel.org>; Thu, 05 Oct 2023 04:47:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1696506426; x=1697111226; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QMR2iarH1SHp4FutOR7HUhuuQeLUkDys2IX/rbsWADw=;
        b=v7b6tw5o/OBbyFdhVYARKjxRW6pNB0ZfOztxOOJCGnF18e7wtvffHOlHj7HchJelX4
         UucMq2O55lzbpvmRL/X5Yk2WRyu20zhUv2MdqGxOrBZ/JduthWIRXeBxsDLxCHOebt6W
         g6si/Yy0tMJLPhOD0PkVF2kKzqTAP8U9AJGsXzJpVleStUPput4FmO9qMNjItwt2nV8F
         IP53vNQEUoTeUXbh8ZXNtgtoOWv8U6Fth+4IjkkGkwHVqdgQX5xh0/VkXd+ssU103qfV
         ysJIp5VI+ZLA7jkOmpfVInFmRpTlHpM4AC7uwkhkLwQvAtuLUFe3X9hRQjmCl8d0eebj
         RtlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696506426; x=1697111226;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QMR2iarH1SHp4FutOR7HUhuuQeLUkDys2IX/rbsWADw=;
        b=YjLxjAFFWCUXhcjn5oZJBbIpi/0jnNemvKCEMyYZNkjNH+ce0FH6qcKoi1bDn7ODt+
         v5hU+h1jMo1KkSwjGyXCCFVd6mKJKbnwIJfZshhSaSiJw58jCu/mO9jfzM3ojuAQuXfw
         j+DZ4uJWTv3RIsRKSsPGj5a5UDumD5JJjddRXNpmREp7fil9lTjvTLup/9iNoPbAo9iW
         fXQuZ05QziBEMHwDn21+MvyWiAdvMQYcxErBp6SY1CV1ZqTVofHVe3JcnH14D7xxiPBx
         Or9JM9WpP/AYApbKpxJkIAOffZAeiNbPjdaPY7pqBFDvaP0cfVesK2GJ1q85qljJErwS
         us/g==
X-Gm-Message-State: AOJu0Yx+BhTvK2fKa3gOANcRmz7gdBttw5ySr7J4VMapJlGpcYw++opD
        yCmnXsbxeWqvmczdL4cQwofhrA6BXTQxD/rNMw/Olg==
X-Google-Smtp-Source: AGHT+IHnauWf5w8n6DaCiT3ykWeC5N/dcnkg2MMYOy+wHUee5AJ5j5YZiGsBVOLC/sFQUAuyzMU7wUjxcXH15gBd2GA=
X-Received: by 2002:a25:7412:0:b0:d80:1011:d2b with SMTP id
 p18-20020a257412000000b00d8010110d2bmr4836599ybc.2.1696506426231; Thu, 05 Oct
 2023 04:47:06 -0700 (PDT)
MIME-Version: 1.0
References: <20230926182625.72475-1-dg573847474@gmail.com> <20231004170120.1c80b3b4@kernel.org>
 <CAAo+4rW=zh_d7AxJSP0uLuO7w+_PmbBfBr6D4=4X2Ays7ATqoA@mail.gmail.com>
In-Reply-To: <CAAo+4rW=zh_d7AxJSP0uLuO7w+_PmbBfBr6D4=4X2Ays7ATqoA@mail.gmail.com>
From:   Jamal Hadi Salim <jhs@mojatatu.com>
Date:   Thu, 5 Oct 2023 07:46:55 -0400
Message-ID: <CAM0EoMkgUPF751LpEij4QjwsP_Z3qBMW_Nss67OVN1hxyN0mGQ@mail.gmail.com>
Subject: Re: [PATCH] net/sched: use spin_lock_bh() on &gact->tcf_lock
To:     Chengfeng Ye <dg573847474@gmail.com>
Cc:     Jakub Kicinski <kuba@kernel.org>, xiyou.wangcong@gmail.com,
        jiri@resnulli.us, davem@davemloft.net, edumazet@google.com,
        pabeni@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Horatiu Vultur <horatiu.vultur@microchip.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 5, 2023 at 5:01=E2=80=AFAM Chengfeng Ye <dg573847474@gmail.com>=
 wrote:
>
> Hi Jakub,
>
> Thanks for the reply,
>
> I inspected the code a bit more, it seems that the TC action is called fr=
om
> tcf_proto_ops.classify() callback, which is called from Qdisc_ops enqueue
> callback.
>
> Then Qdisc enqueue callback is from
>
> -> __dev_queue_xmit()
> -> __dev_xmit_skb()
> -> dev_qdisc_enqueue()
>
> inside the net core. It seems that this __dev_queue_xmit() callback is
> typically called from BH context (e.g.,  NET_TX_SOFTIRQ) with BH
> already disabled, but sometimes also can from a work queue under
> process context, one case is the br_mrp_test_work_expired() inside
> net/bridge/br_mrp.c. Does it indicate that this TC action could also be
> called with BH enable? I am not a developer so really not sure about it,
> as the networking code is a bit long and complicated.

net/bridge/br_mrp.c seems to need some love +Cc Horatiu Vultur
<horatiu.vultur@microchip.com>
Maybe that code needs to run in a tasklet?
In any case your patch is incorrect.

cheers,
jamal
