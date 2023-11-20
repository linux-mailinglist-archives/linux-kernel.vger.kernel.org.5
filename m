Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D2FA7F0CFB
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 08:46:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231997AbjKTHqC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 02:46:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230183AbjKTHqA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 02:46:00 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13292B4
        for <linux-kernel@vger.kernel.org>; Sun, 19 Nov 2023 23:45:57 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-5484ef5e3d2so3533489a12.3
        for <linux-kernel@vger.kernel.org>; Sun, 19 Nov 2023 23:45:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700466355; x=1701071155; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uGUSPipm8cHx9uqpOKEqNlZRVI6FwrP0qizfWCjAeMo=;
        b=I4hxQZGW05aTZiZqiXDxz7W77h4MqlnFgDPc1wVScKgDYaXmM0nQ/uF0oNePZK70m9
         51dfy/eudKSNdYsCGY2Oy/UPoMu9ydzAahQeNeCLZoVQH9KZWCzDbCwXsB6PNe3a8Hrp
         sXWHgO5IU7CST5EwjUeV5w9uYjQT+zR8QFbpWkeOIuvTRnyMonQdEciG7WSFDBwlqWSc
         mdLRscsGGWOeQitTDgzy5Ayf3snFXdwu1qOvM7+Vo0PgRaITssg4H2A5lYe7VNK23Nik
         2xPEDGk0j1n8Z10XNMiM47Ofmw7r9wMon0xogGWVk1HezxvPdaTdmNo8TNSErvASH0I6
         sVCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700466355; x=1701071155;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uGUSPipm8cHx9uqpOKEqNlZRVI6FwrP0qizfWCjAeMo=;
        b=ai+uvYvjCdMvPOSkl0Vo/s5gbcnxlLDl5ifAUdKzi56rt3kFyqBTWybpXY+HO1oLTI
         AhPh9rMwJ1AnMkCJIoxZWf4zDu0irFiq3f03TF3G9gOfoxhjyzO2kJJ2TJJDIcv//4pr
         ZwsAkaElSpfV/rj+t+eBQkppyuXqgRxCN54/Yfilh1QbTFyUXof/Cpi057TXuBFhJzLS
         aTdad/S5NjKKj4TW4GWIHR7rwmDfpwk7CRn9+29E0cutAY9Ldw5YKbNPJUO0PTREwFj4
         dqn9CFR8uOXyn1AKhJV+h0D08qD/jJpncQxoA9ngYqvhD6LjDV4Jy6QLs/0VqMcUu9O3
         CFjg==
X-Gm-Message-State: AOJu0YyaDd0Wcl7axludv+nBAOcHOW5B3gtieJD6rcUlNpIyTHywgxxa
        dt7DP78Tiu8a/yZb/bNL/h+zW9jksEQcvgu88jU=
X-Google-Smtp-Source: AGHT+IE5C9XEjQ/gOCPjI4f8lJqiNZH4NHSd+2y3h4aF8BDrr7idyOMADa4cj4tCUkrLvRAKMbDZlh/7mlYiLVzKPMI=
X-Received: by 2002:a50:fc18:0:b0:543:566f:2e89 with SMTP id
 i24-20020a50fc18000000b00543566f2e89mr5098119edr.37.1700466355423; Sun, 19
 Nov 2023 23:45:55 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a54:2acb:0:b0:23f:99b3:55ff with HTTP; Sun, 19 Nov 2023
 23:45:55 -0800 (PST)
Reply-To: andersonmorris490@gmail.com
From:   Morris Anderson <t3997936@gmail.com>
Date:   Mon, 20 Nov 2023 07:45:55 +0000
Message-ID: <CAJYqmPp2FK98FNRAv5m98ahqypO56Vxajz7PJk2LJhXS_SsSUg@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.7 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-- 
Do you see my message? I sent you an email but no response what happen.
