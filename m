Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D1CB800FA1
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 17:13:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229751AbjLAPuf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 10:50:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229644AbjLAPud (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 10:50:33 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B814F3
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 07:50:40 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC8FCC433C8;
        Fri,  1 Dec 2023 15:50:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701445839;
        bh=SyIC/HkVOiHxd5aY9Ss3kPjVyeje4JbpChA97X9KnfQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=u7UxdtxIA/ZDwTc6kU3tarNl4O/39gFz7JPd0ZY9plzGETGRc8h7KX7VnFZEL+vTs
         zKDsDLLlo3W4IDdkoYYZFABL9N1MloskLuno/bSJ/NxsQFBNjupSWVIVWxUG1+IGtl
         j2c4Y34Ek8oE4JAnVb9fnOSJC7CzFnFpuHkGM6G0phuyKrk5dQHbQPVJ+7vUVFIjiZ
         oEcqEyuiwNU9Sv2/IdOgeRk5poLANGfX2k8aid9KYB/7zgEsjA3LjpYq/dxjF6Fs+w
         W+Ozxa8waEGdHrXo1hEoE5pjWXYoxIuUFVYcXrqtTtIcNApXXz4zPT5/csUgHMbX5Z
         gfPh563wlvfzA==
Date:   Fri, 1 Dec 2023 16:50:34 +0100
From:   Christian Brauner <brauner@kernel.org>
To:     "Seth Forshee (DigitalOcean)" <sforshee@kernel.org>
Cc:     Serge Hallyn <serge@hallyn.com>, Paul Moore <paul@paul-moore.com>,
        Eric Paris <eparis@redhat.com>,
        James Morris <jmorris@namei.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Amir Goldstein <amir73il@gmail.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-security-module@vger.kernel.org, audit@vger.kernel.org,
        linux-unionfs@vger.kernel.org
Subject: Re: [PATCH 03/16] capability: rename cpu_vfs_cap_data to vfs_caps
Message-ID: <20231201-anregen-haifisch-02bb75192a7a@brauner>
References: <20231129-idmap-fscap-refactor-v1-0-da5a26058a5b@kernel.org>
 <20231129-idmap-fscap-refactor-v1-3-da5a26058a5b@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231129-idmap-fscap-refactor-v1-3-da5a26058a5b@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 29, 2023 at 03:50:21PM -0600, Seth Forshee (DigitalOcean) wrote:
> vfs_caps is a more generic name which is better suited to the broader
> use this struct will see in subsequent commits.
> 
> Signed-off-by: Seth Forshee (DigitalOcean) <sforshee@kernel.org>
> ---

Yep, looks good to me,
Reviewed-by: Christian Brauner <brauner@kernel.org>
