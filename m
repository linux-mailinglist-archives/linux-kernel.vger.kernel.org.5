Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25967762138
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 20:18:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231506AbjGYSSm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 14:18:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230027AbjGYSSg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 14:18:36 -0400
Received: from sonic306-27.consmr.mail.ne1.yahoo.com (sonic306-27.consmr.mail.ne1.yahoo.com [66.163.189.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 680101BFA
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 11:18:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1690309114; bh=+mEV6x+zzmYuyWd2xXHOlq08a9u6dgdxgRHuWU4jLzM=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=jqk+lFi0LMVUdKz/b6tntH6wGKEqgKnmJbC0dnuDaM8thvT2fSrq07KrwWdNygq9GoIPcPFlN0n2Da8E65ylzn0EPjtJHeBNQ/NFUVV47RvsRb4y990uZ54kL+iWgAtLZPdRLGndbYSiOeFkGmuyFISqlI4VOCzZ03QOc2KFwszrPmVbzEYay2aFET0C7QO34HXtEvD3gQSLXzFaHE0jncILkvQH2A7kkvYW0BhTfotam0AGCvmDGCXRmwKhOdiL+Ivx7b2uf5TTKwLpjmvWPtu347ZTPXorY/oDK7lFUr4PB+SNnRHfa+wH7jshAx5tBJ2cqyP6QQ87g8L2gtqZlQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1690309114; bh=l2h7/CZRiPG4/5UFXPKXH1+RsKAl5V2zKAgD7JykGkQ=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=qPFpYlWCOiYq5W3N3tQ5/XCZS+nwl32aUl0MgU+aL6OBB4EFYNbPLVF5oDIzElLeeZfl6grIhl5jPSEbjdb6bWq3MgZoUMdw3H7/Nh4fokjZ1mYlycYLHDRyBBx6shmV6rrHS576j6Hr68F++/DPAY0y7DPq9RNwoyUnElCEzaFyYbW8+9JUI6K7hCodryDlC7ZMApfKM79TUpJDEXP8idnczki7xt9NujW3I4H6YfQe7XTOPTYQHD3IQvNLLJof0i687gqe+2xNgDXkS0ltFajAuIp/bIH/beQ0ZUwLq9hNdd/FZaBlvmTqDmv6W2aJHEy13WnsDd4o1dj0Hg8xdw==
X-YMail-OSG: dtjRU6wVM1m9ndmAhvAP_EiOx2nfNa63L2MxkbLiYhEx5E.3nUMPI8tbYvJ4sNR
 M8dTF4SjrvE6u20FYZ.8z7dcUr437J7ytssuOxwnBTYeVg2aFENp5ObNeR1w8zvGdQ27VAmfj3yB
 .WRrUnC5BdzPb8zZh.9h0ta9at1ni6k_57TGuUy3.hv9hE2AGac.3cuHet0dg5UbZ9hjoOGjvU47
 H3PJO8wcEjx3HZYGpk__ogJM4APD_S7fwXdBBhMmGPn5q.G36xQ0m3uUXlqigCroSuql_77qEMpa
 8vpZS7SJZnCQEnoLR.RRqYJnkUukTkhjL8BaYQCs6vIYVzd_z3SBR.2pZofYddMApGHRxeDzidI1
 9QJZNrJZ.myFWhd7M91oQ3_dSYKq.DUFwrlX5xLDsLvY6TO7ubxPt5xQPAME86IR5icwKF1xsg2F
 TAY_Ek.0rSTpBDXAIaCMnlvEvL0i756roxCODfI71QQaEsKkDSxdHlqOWOYehryAaE_Ptxw1QQwq
 RrO4oXox.aoGrlZNqZ_35ADKDwKml86byWLH4u_89JB37S1dMbNzlCp4nT6zaG24v9xZZf5Gnx0F
 X6uJhi1sIqPO2TyY7Lu0PUvj5E0n603q5OWw.s6ycTy79BMN.Tv9QYHzN0SYddYUGhSSapECq1Uu
 dv49a6qDkViIZ4hmMkYA0YJh2Bv3elnfK7wJnUy6JY5unvhIg4u2VyoUMDlcxOc71yXmHSy_chEg
 5ydP2lTTa.T9vOhXGNJUFcKHBwNnFeob5BUmtmqX9eHAqlPcgggV3iA.kQMXmyIaMuXgM1wd13p6
 uLYR6leHNlf.lPryRCIEN5jLtPBeySXF4D8NtdNYzLxOuddn58AgglbvtAe9n2_rHNNwTHJRY78i
 3nsZXhSoejWdoqRmFBZX513KmJNfaUtyChKsTmR10krKjId_PEgZcAYFMCdabx6L0APyUOUlbjDo
 i35PqNkJ0tLKiBmjs4iVu3nCfUomsBzEmx2kkQ3_BSHj7.QoXb7EaMkVhUdDZgXNkkYsWyJqo5KR
 5KYgQ5ZOnJo8u4wRe5ta1tddgu8VtRY6PSX9NnSIekAyw4Qpm6owqExqkdmnXy_NLJL12lPHGryo
 WkDLpS2pJM2VnNErfc8ZqfnMH_UWwK8nw5CsNFL_cbfwr5nTDXuz0MGXZWIXieT3GSCPDb3B4DFp
 BI8Zslq4rYYF6zvnv_GnVYIo3r1U0IrRLTDFeXh2_8utGpxxzCk2km7IQJAOv9rRgB1KP48xFb3M
 0bvCh0I1ivqXb0wQnJ43mLJVFK.VM2F.ZtRBdFdIUv3DbeLUF0R8.0S_Ki_PRf6l6RWZzwFOW6dm
 8Y4z5O1Fe2UT_AsF4cJnvWuyIp3PlaOCBQMUVUrpzEJEMmdHhs5BKT9OY9E1F0qculbyVVlr76Gf
 IgBDGWWdjN.cZjKYCzTsSuIZB_SD2FTpuhn3TDcT4W.VZP6bxp5uI7MphajyK1pUQlFei9Vhut7J
 a6RytVQypXz6txAXJa77LH.xMCnQWy8MGKk6HJ8SjetGQdyaqb_QTYWvPsFGf81zcmpzyJbZxE32
 6i4_yjYlm1.JV3iVIUbmFGnZ7So.jWjS0sCvqTIUSj1lUhHUdX.v4Zo9dobiwhepeyzhKTboWoyV
 n_Aw9WmeEMUhdEiKuPVfCTi3odZJYZqJTznLa8KVAHU2R5uQhRjHXfuvpMNAZMsXdNMVnMEhn.TV
 WUpSAbhbryPYL2rnrVpxNnKF7XubE12nj8PTTv0xWHgSo_BDd7JZFQ6um8Sw._9XEQI_pRw2OpF3
 4sDOY_.mn1pvC6ypVMiy29AM_BOaM8.VMyO.y60tVwtDRDCTDKrndRX6YyP2vPT5dlL92_CN6EdZ
 JGmeGz_Yv1YYzdRH5nY8fW3FGFHOFWBqeiaW.8sZTKPDoYmpicjYyQtKPDnnXokEe4Zk.JYq9iHP
 Uf4S6_K2BoofmZ4DeNfETtODdCHCeCRHTrJ.qm17VOYrGKJB9mCVAZ6tnR7rb7M5j.ktw9HMgpIf
 AKiykdao9jcvhQnkTbmd9F..rWnY04tHJGWUrqldwMgsAJAPddyLkZkm_5XKi.WdQKbsCUCqzL0S
 GnZcfSLWWaJfTAn9tWzmv1g9VZoqyktUmh1b0DR0VdSnMCxYAMfWglI8ay7MtEd.FHhQZ0BXVF4h
 gPZxjayWgRVK8btVXobpcI05Dfk4oeNi9esTFVtviMPihKsaxFhn.Zqah2MLPtZmecGPZQ_E3nL4
 wbOtHm5vFbiW7waxEtyDmwUNqNl2myr.ZnaAWuxedE5mpvFKjTpX.PcqScPkx4qvWp5BT7VTzHJ_
 uMzPf9Jn2C_qq
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 6d6edb3f-75ea-4e6a-beab-91b94679ec9f
Received: from sonic.gate.mail.ne1.yahoo.com by sonic306.consmr.mail.ne1.yahoo.com with HTTP; Tue, 25 Jul 2023 18:18:34 +0000
Received: by hermes--production-ne1-549c7f6c44-r55n8 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 8326ca44c4641a54882626013ee7d6bc;
          Tue, 25 Jul 2023 18:18:29 +0000 (UTC)
Message-ID: <ff5a4dc7-579a-883b-1608-7d8d08ba8cb8@schaufler-ca.com>
Date:   Tue, 25 Jul 2023 11:18:28 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 0/5] Smack transmute fixes
Content-Language: en-US
To:     Roberto Sassu <roberto.sassu@huaweicloud.com>, paul@paul-moore.com,
        jmorris@namei.org, serge@hallyn.com
Cc:     linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Roberto Sassu <roberto.sassu@huawei.com>,
        Casey Schaufler <casey@schaufler-ca.com>
References: <20230724151341.538889-1-roberto.sassu@huaweicloud.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <20230724151341.538889-1-roberto.sassu@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.21647 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/24/2023 8:13 AM, Roberto Sassu wrote:
> From: Roberto Sassu <roberto.sassu@huawei.com>

I'm testing these relative to smack-next.

>
> The first two patches are obvious fixes, the first restricts setting the
> SMACK64TRANSMUTE xattr only for directories, and the second makes it
> possible to set SMACK64TRANSMUTE if the filesystem does not support xattrs
> (e.g. ramfs).
>
> The remaining fixes are optional, and only required if we want filesystems
> without xattr support behave like those with xattr support. Since we have
> the inode_setsecurity and inode_getsecurity hooks to make the first group
> work, it seems useful to fix inode creation too (SELinux should be fine).
>
> The third patch is merely a code move out of the 'if (xattr)' condition.
> The fourth updates the security field of the in-memory inode directly in
> smack_inode_init_security() and marks the inode as instantiated, and the
> fifth adds a security_inode_init_security() call in ramfs to initialize the
> security field of the in-memory inodes (needed to test transmuting
> directories).
>
> Both the Smack (on xfs) and IMA test suite succeed with all patches
> applied.
>
> By executing the tests in a ramfs, the results are:
>
> Without the patches:
> 86 Passed, 9 Failed, 90% Success rate
>
> With the patches:
> 93 Passed, 2 Failed, 97% Success rate
>
> The remaining two failures are:
> 2151  ioctl(4, BTRFS_IOC_CLONE or FICLONE, 3) = -1 EOPNOTSUPP (Operation not supported)
> 2152  lsetxattr("./targets/proc-attr-Snap", "security.SMACK64EXEC", "Pop", 3, 0) = -1 EOPNOTSUPP (Operation not supported)
>
> The first one is likely due ramfs lack of support for ioctl() while the
> second could be fixed by handling SMACK64EXEC in smack_inode_setsecurity().
>
> The patch set applies on top of:
>
> https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/lsm.git/commit/?h=next&id=ca22eca6e2ad7eaed1c791628ef7cb4c739e3da6
>
>
> The ramfs patch potentially could be useful to correctly initialize the
> label of new inodes in the initramfs, assuming that it will be fully
> labeled with support for xattrs in the cpio image:
>
> https://lore.kernel.org/linux-integrity/20190523121803.21638-1-roberto.sassu@huawei.com/
>
> Ramfs inode labels will be set from xattrs with the inode_setsecurity hook.
>
> Changelog
>
> v1:
> - Rebase on top of latest lsm/next
> - Remove -EOPNOTSUPP check in patch 5 (cannot happen)
>
> Roberto Sassu (5):
>   smack: Set SMACK64TRANSMUTE only for dirs in smack_inode_setxattr()
>   smack: Handle SMACK64TRANSMUTE in smack_inode_setsecurity()
>   smack: Always determine inode labels in smack_inode_init_security()
>   smack: Initialize the in-memory inode in smack_inode_init_security()
>   ramfs: Initialize security of in-memory inodes
>
>  fs/ramfs/inode.c           | 27 +++++++++++
>  security/smack/smack_lsm.c | 97 ++++++++++++++++++++++----------------
>  2 files changed, 83 insertions(+), 41 deletions(-)
>
