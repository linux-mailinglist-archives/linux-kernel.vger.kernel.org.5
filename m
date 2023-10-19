Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3349B7CF6E3
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 13:33:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345329AbjJSLdG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 07:33:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233048AbjJSLdF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 07:33:05 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21400C0;
        Thu, 19 Oct 2023 04:33:04 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id ca18e2360f4ac-77acb04309dso316593839f.2;
        Thu, 19 Oct 2023 04:33:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697715183; x=1698319983; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=vR4oIaKl7VukEPLoRxulPlCo1LPKKIgD+yZZhVz/lzA=;
        b=TcahNRSDTocYilNNoeEygnawd+pCvgdLol9EvGTFsLktUX3WrgGHgNQK04qojWrAQT
         DhvxEMJtjOSUeNAQzjrxg2t4zgEiPx5GonB5jJCBuCHB4O03Kz7UlglFzWB8znG7iaIz
         k2Sd0nX3NWI85Kpq2bdrgZWdQpRyBzjVjF/F/rLeJW1ZIkDj/mZNYtcZw+n9haUp4ev3
         8aKjwWXUlMAaP7SEZY6423Dg+2PKh0PgRLjJGzDhINuVQF/KJqJ7wNdHSzD5QHz+tZni
         oxrre4KtcI8FHXsq4ALAEH22Ooir1o7nsLLxsF5odE5NAkibqLi18mr4M/E/JxKvy9q1
         BIqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697715183; x=1698319983;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vR4oIaKl7VukEPLoRxulPlCo1LPKKIgD+yZZhVz/lzA=;
        b=vWx71tl9vnNesxVUN6q9mIvXyWZIkWra6lVplTuZqTItNe0DATI7kma8GkOn4HGOYi
         mZgz6sPh7svPbQqwS8i3NPFwJ8RpKhcWFRvJiUjn52BeBjnrjgUO+9/uqI53PBaEGy1l
         0rlMwT4iH5hlIg8tNKk1eoCYhhtxrEETb4tstuqRQcI+dI7R50FTOypqlm5RqcR18wDj
         JbY9/2IPVVAHtdpOz1A052q6hZGhighaiuKu+cOCfUN1PCdlItWIOuBtgfu8E/NIncA1
         OwtV/5afWiF6e89atAg2RiSjypt0j7DicsoRe0z5l1mmxO8CiO/7OOH1vUAXZonDItVR
         NPTA==
X-Gm-Message-State: AOJu0YxKQH5hhD4EamS1ILWs78+NNypAXbxRkPJjjAlsRfjbzZoAAdmk
        7tGEoljjN8Xgs4J7SzgPJvONJ8qcnEw2QYRmD/I=
X-Google-Smtp-Source: AGHT+IFrDqKVC92ajXINvyayX7fRbh4tnLvmdy2wgUFpPgqZgbDrETvEaAKvR4BNzt3HU5dNk+czxTzLstg9Hoafm9M=
X-Received: by 2002:a05:6602:2b0b:b0:787:34d:f1ea with SMTP id
 p11-20020a0566022b0b00b00787034df1eamr2626387iov.8.1697715183402; Thu, 19 Oct
 2023 04:33:03 -0700 (PDT)
MIME-Version: 1.0
References: <20231019032122.1594649-1-kernel@monoid.al> <CAB95QAR-UbfVULOCaZMO4H1AgvzbiHEoSYk-DiYPY6Pg-i7Vag@mail.gmail.com>
In-Reply-To: <CAB95QAR-UbfVULOCaZMO4H1AgvzbiHEoSYk-DiYPY6Pg-i7Vag@mail.gmail.com>
From:   Eugene Shalygin <eugene.shalygin@gmail.com>
Date:   Thu, 19 Oct 2023 13:32:52 +0200
Message-ID: <CAB95QAStiK=8ZD8yaSEtWbzt4vbB+EhjrEs259DYiimJSREDDw@mail.gmail.com>
Subject: Re: [PATCH] hwmon: (asus-ec-sensors) add ROG Crosshair X670E Gene.
To:     Ellie Hermaszewska <kernel@monoid.al>
Cc:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Oh, sorry, I misread the board name. Please scratch the bits about water temps.

Cheers,
Eugene

On Thu, 19 Oct 2023 at 11:43, Eugene Shalygin <eugene.shalygin@gmail.com> wrote:
>
> Hi,
>
> Thank you for submitting the patch! I don't understand how does your
> note that only the T_Sensor presence can be verified correlate with
> SENSOR_TEMP_CPU | SENSOR_TEMP_CPU_PACKAGE |
> SENSOR_TEMP_MB | SENSOR_TEMP_VRM enabled. Could you clarify, please?
>
> Based on the EC registers dump you provided [1], I believe it is safe
> to enable Water_In and Water_Oout sensors as well.
>
> And please add the board name to list in Documentation/hwmon/asus_ec_sensors.rst
>
> Cheers,
> Eugene
>
> [1] https://github.com/zeule/asus-ec-sensors/issues/42#issuecomment-1742062260
