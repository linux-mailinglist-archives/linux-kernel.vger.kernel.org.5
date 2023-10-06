Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D94457BAFEE
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 03:08:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229667AbjJFBIO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 21:08:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbjJFBIM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 21:08:12 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7A9CD8;
        Thu,  5 Oct 2023 18:08:11 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40EC3C433CB;
        Fri,  6 Oct 2023 01:08:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696554491;
        bh=CgMSA4QfDKYOJoZMcXjw6f7wxM3hoXO3cvyl6n/VfBY=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=r9Bur9pdGOXRdqT2LPMxMJw4GiKOc1AnHibse9R4aQtmAmUDP6DiM4HuVgXv/WJzf
         llLEastI2/PKBE/MY/ENDQMcuJCLUe9JT81/BslQEa1JdPNzmOhTewZXlIWahDRo6d
         xONoDnkJ9naQRXaqXtdWT390gwMnP/xWE9mfl6Z9HIxoqzwxkPXqSgqhvYgB/eTW07
         HQzW42WTue7c2iATxC73SpngGs8cxSaeBszUXKs154A5BMnlZf3sNpZfXSxU/y2Wy6
         XKYyviX6Pr6icpj8ssHtJnG1ydUd2B/8cueAValHAJyMCXL3Ngwrf0SQ6+fqHEMy/j
         +GdIdd2LcjJlw==
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-57bb6a2481fso847723eaf.1;
        Thu, 05 Oct 2023 18:08:11 -0700 (PDT)
X-Gm-Message-State: AOJu0YyLTFUJzofG70BteqjY74n+wFCrpmi2dG7f4XoTWNoW2Nvk+vX/
        AtSNoZl5/CtsLFLd2N5eruqz6pvvXFpJVmUDJG8=
X-Google-Smtp-Source: AGHT+IFlyLSbl3nrfTwv+jGaZu3ipdNNtmvz9xNoia5rKOvFfFq6z/0wJTHQ2k5G2rja0rE1qwPuBMrLRdPB34abHNQ=
X-Received: by 2002:a4a:2518:0:b0:57b:734d:8993 with SMTP id
 g24-20020a4a2518000000b0057b734d8993mr6503881ooa.1.1696554490537; Thu, 05 Oct
 2023 18:08:10 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac9:7b41:0:b0:4fa:bc5a:10a5 with HTTP; Thu, 5 Oct 2023
 18:08:09 -0700 (PDT)
In-Reply-To: <20231002053203.17711-1-hank20010209@gmail.com>
References: <20231002053203.17711-1-hank20010209@gmail.com>
From:   Namjae Jeon <linkinjeon@kernel.org>
Date:   Fri, 6 Oct 2023 10:08:09 +0900
X-Gmail-Original-Message-ID: <CAKYAXd_bgVq0r6-fC31sWeia1w27=dEdNnHPzxynnfttV-VLNQ@mail.gmail.com>
Message-ID: <CAKYAXd_bgVq0r6-fC31sWeia1w27=dEdNnHPzxynnfttV-VLNQ@mail.gmail.com>
Subject: Re: [PATCH] ksmbd: Remove unused field in ksmbd_user struct
To:     Cheng-Han Wu <hank20010209@gmail.com>
Cc:     sfrench@samba.org, senozhatsky@chromium.org, tom@talpey.com,
        linux-cifs@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2023-10-02 14:32 GMT+09:00, Cheng-Han Wu <hank20010209@gmail.com>:
> fs/smb/server/mgmt/user_config.h:21: Remove the unused field
> 'failed_login_count' from the ksmbd_user struct.
>
> Signed-off-by: Cheng-Han Wu <hank20010209@gmail.com>
Acked-by: Namjae Jeon <linkinjeon@kernel.org>

Applied it to #ksmbd-for-next-next.

Thanks for your patch!
