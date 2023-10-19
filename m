Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F16897CF43A
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 11:43:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345043AbjJSJnb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 05:43:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjJSJn3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 05:43:29 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D028106;
        Thu, 19 Oct 2023 02:43:28 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id ca18e2360f4ac-7a269637b98so282237139f.3;
        Thu, 19 Oct 2023 02:43:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697708607; x=1698313407; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Irel4QvYAZOPIg1/WIHNQtWdDOjGV4tjoY9E6o8fSoE=;
        b=I2TnY5PaQGExkm9+QJH/Y5++df4+pWAsoLN1IHU0RsriIHtaT5MS+d3/Kg0vqvavxM
         GgJ4+PS3ndMc9Zc8ILqVTiUy9MIQf555CJ+PVg7ZuUVdsp80NpzV+DfyJ6ieDvY5NzEa
         qujRAZ1NcTZV1a7RWwHV/H8csTYQdTWj1uPgkshDLVX2sQbZhBUCap3LWMwfglk6/1qX
         qsEROt6mZ05pgCnt/THowfCQeijy7Pt1TkzFvb6qqhxVKuqJ8hiZGn+iRqKwc/tQklZM
         vAAnRsHNz7Rkl0nImAC5TCF5GpXxI7dMrZW0IhUp/187dLk1qtnNXMA0xmkyTPnLuZqK
         Nt6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697708607; x=1698313407;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Irel4QvYAZOPIg1/WIHNQtWdDOjGV4tjoY9E6o8fSoE=;
        b=otBBqGMyCxRrJEza5ld6z/zoPdLPsldSNDcfwnEuosBt3iRZtdQv7IuTaY2cD5Z0hK
         YyxX7McBpgEiq0C1cdmeZAcuSfdI6zsVEc6rF/OlZoQWvG5PTrDgEgEYDTcD1DrX/q0L
         7ok5QgGxNfcIaedmi6dL6Tm4EN1PUc8vRv2mH6RbakftLGBhunHktBk5c3FTiJwDOtYR
         sJbDywYfIjCe7QOnGOSVoRFESLsXO5bQZgSjJKWSQYVNjE9UsLnH3YAzPoIJFDhphaTU
         u6QmRHRT4RVQT2jkYWF4/YI2Kjd4retbqbpIZGgen42YMNxOvYfnj8GIXPhZM0udVaV1
         SeBw==
X-Gm-Message-State: AOJu0Yy7t7ICti+nJBnyz3jkeHtJasH8MG3qSPQrgZ5l/PXlP2Hak718
        1LEyTsmv8UWK7Ss9KbJME+mZq+06Nr5cQ6CXfTdReUmIt8U=
X-Google-Smtp-Source: AGHT+IF62fs6ujxW2XujjLx9NTZQhFBo+/mBpYwbYYr3GRkxftjEIBk9P2wtZGH2UyNUP3+9329BdFH52wtH8pk7Tig=
X-Received: by 2002:a05:6602:2b93:b0:786:2125:a034 with SMTP id
 r19-20020a0566022b9300b007862125a034mr2010050iov.18.1697708607564; Thu, 19
 Oct 2023 02:43:27 -0700 (PDT)
MIME-Version: 1.0
References: <20231019032122.1594649-1-kernel@monoid.al>
In-Reply-To: <20231019032122.1594649-1-kernel@monoid.al>
From:   Eugene Shalygin <eugene.shalygin@gmail.com>
Date:   Thu, 19 Oct 2023 11:43:16 +0200
Message-ID: <CAB95QAR-UbfVULOCaZMO4H1AgvzbiHEoSYk-DiYPY6Pg-i7Vag@mail.gmail.com>
Subject: Re: [PATCH] hwmon: (asus-ec-sensors) add ROG Crosshair X670E Gene.
To:     Ellie Hermaszewska <kernel@monoid.al>
Cc:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Thank you for submitting the patch! I don't understand how does your
note that only the T_Sensor presence can be verified correlate with
SENSOR_TEMP_CPU | SENSOR_TEMP_CPU_PACKAGE |
SENSOR_TEMP_MB | SENSOR_TEMP_VRM enabled. Could you clarify, please?

Based on the EC registers dump you provided [1], I believe it is safe
to enable Water_In and Water_Oout sensors as well.

And please add the board name to list in Documentation/hwmon/asus_ec_sensors.rst

Cheers,
Eugene

[1] https://github.com/zeule/asus-ec-sensors/issues/42#issuecomment-1742062260
