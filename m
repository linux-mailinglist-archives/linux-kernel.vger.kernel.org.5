Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 097CF7BE5A3
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 17:55:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377075AbjJIPzS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 11:55:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376948AbjJIPzQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 11:55:16 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A5D092
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 08:55:15 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id ca18e2360f4ac-7a24c86aae3so59605839f.0
        for <linux-kernel@vger.kernel.org>; Mon, 09 Oct 2023 08:55:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1696866914; x=1697471714; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XruG8yWRGGDN5qd6vqt7z5HjJHH+0pwbdf8yXuDMp/E=;
        b=gy04d70srNpH1/O7qKkd1t9AcbXqOSAuuuW7MX+Hky2nRBUsTej11EBEQxX4HAU7LE
         CThbgb5ZOrieHUO1jGqhJ3L1+TJEbx8HGcArUwtlZFk8y3PUqK256c9rw7eFDI5ekOME
         zim+oexU4GaDyYav/1ust+FYrtb8YjbNStyp0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696866914; x=1697471714;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=XruG8yWRGGDN5qd6vqt7z5HjJHH+0pwbdf8yXuDMp/E=;
        b=qd2OX8iF5RjnzK5pyNVtjoIKlqxSTNKYLQPc5cIhDkts7+dVgiw6lda7JfM6la050r
         IQrjH3ur45JL3M4EGCON8FtXnSjRM3/rTXUjuGPah1gYj495bH0E2oJvhc5qyG87PlNY
         9ozfLoD7F6FfSTl1TalogRfsECezBrzdHG3ObQ5OEKupATNav9Sal4V2NOFibSA8oQGR
         AM0hA6aoQsgIM1sHZ2NI92hA2NkwR44huJNUh/yBxhXUwZw+OPk+XNJjRmaGmeL54rqn
         WCXQvN3c4BckcG6qUSz196tNDh/YRsvrvoyzd9LVfq8W2yr7XTA6F7dlwZLWQEgdvKlZ
         cZ3g==
X-Gm-Message-State: AOJu0YyS1o5CLi+U4A2cM3xjqKr6sw6WUJ5UN1oO6XgrXTWpDRb9dM1w
        qBk5iWwLt3xckP3y0A1VdRucgMguNrrll0cblK0=
X-Google-Smtp-Source: AGHT+IGDBW7sDvgrLewaeuThkesBT8PDWI8e/QvSWXV7ow0vk6x35tLiQ4hbzIq82T51w7tWhBcdmQ==
X-Received: by 2002:a6b:5a0a:0:b0:790:958e:a667 with SMTP id o10-20020a6b5a0a000000b00790958ea667mr15125455iob.2.1696866914183;
        Mon, 09 Oct 2023 08:55:14 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id s4-20020a5e9804000000b007925328d6ddsm2526616ioj.20.2023.10.09.08.55.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Oct 2023 08:55:13 -0700 (PDT)
Message-ID: <3351be6b-854e-479d-832c-83cb8829c010@linuxfoundation.org>
Date:   Mon, 9 Oct 2023 09:55:12 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To:     linux-kernel@vger.kernel.org
Cc:     "conduct@kernel.org" <conduct@kernel.org>,
        tech-board <tech-board@lists.linux-foundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Subject: Linux Kernel Code of Conduct Committee: September 30, 2023
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linux Kernel Code of Conduct Committee: September 30, 2023

In the period of April 1, 2023 through September 30, 2023, the Code of
Conduct Committee received the following reports:

Unacceptable behavior or comments in email: 4

The result of the investigation:
  - Education and coaching clarifying the Code of Conduct conduct
    related to normal review and patch acceptance process: 3
  - Clarification on the Code of Conduct conduct related to
    maintainer rights and responsibility to reject code: 1

The reports were about the discussion during the patch review and
decisions made in rejecting code and these actions are not viewed
as violations of the Code of Conduct.

Please see the excerpt from the Responsibilities section in the
code-of-conduct-interpretation.rst document:

"setting expertise expectations, making decisions and rejecting unsuitable
contributions are not viewed as a violation of the Code of Conduct."

We would like to thank the Linux kernel community members who have
supported the adoption of the Code of Conduct and who continue to
uphold the professional standards of our community. If you have
questions about this report, please write to <conduct@kernel.org>.

--------------------------------------------------------------------

This report and the past Code Of Conduct Committee reports
can be found on the Code of Conduct website at

https://www.kernel.org/code-of-conduct.html

thanks,
-- Shuah (On behalf of the Code of Conduct Committee)
