Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2732757313
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 07:18:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230167AbjGRFSU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 01:18:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjGRFST (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 01:18:19 -0400
Received: from mail.208.org (unknown [183.242.55.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE11F1A6
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 22:18:13 -0700 (PDT)
Received: from mail.208.org (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTP id 4R4nKC1Dr3zBQskw
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 13:18:07 +0800 (CST)
Authentication-Results: mail.208.org (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=208.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=208.org; h=
        content-transfer-encoding:content-type:message-id:user-agent
        :references:in-reply-to:subject:to:from:date:mime-version; s=
        dkim; t=1689657486; x=1692249487; bh=+T4mGyqqVA4q4Wd03BJcjylbrLn
        9yRLGL9WoLEwLWZU=; b=Rj2Iz+Dyt1XmDfNwVL3sYbVm8AD7iYAORa9uYCFF3bD
        tCGRLL2V1TQV8LPHSqjhKtO0lQvHt//LEpXGD4IrsWE/Al39qaEoGXnkdcSzGQ6V
        xchnWrNnP2EJQoPfuhSRz+jniw5d/h2LBtIFb5BZjBV3DLDX7doX65ZtjNztUQEO
        uINv9/p8FkovvFMMqoJa1frD0WMp3xqBrxTFZM+8GOr9qaOFXlJ9FWxNiU95HvTu
        Ktjwm2tWUN3WEkJFB6sJ+v6B+R808qLQVndJNN9M5ACcEK9yXUOR4/k/oSJXVmzL
        Now5++lIqXxQ7bR52nHb21UqmW9HWV5yP6XAfWjPuDQ==
X-Virus-Scanned: amavisd-new at mail.208.org
Received: from mail.208.org ([127.0.0.1])
        by mail.208.org (mail.208.org [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id htzesgh6H3mn for <linux-kernel@vger.kernel.org>;
        Tue, 18 Jul 2023 13:18:06 +0800 (CST)
Received: from localhost (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTPSA id 4R4nKB4klFzBQskp;
        Tue, 18 Jul 2023 13:18:06 +0800 (CST)
MIME-Version: 1.0
Date:   Tue, 18 Jul 2023 13:18:06 +0800
From:   shijie001@208suo.com
To:     masahiroy@kernel.org
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] kconfig: gconf: Fix errors in gconf.c
In-Reply-To: <tencent_A89FDF5260295CB618D587A53D21C96FF90A@qq.com>
References: <tencent_A89FDF5260295CB618D587A53D21C96FF90A@qq.com>
User-Agent: Roundcube Webmail
Message-ID: <90e8f79ec40ab4ce1c7e7961cb77a012@208suo.com>
X-Sender: shijie001@208suo.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RDNS_NONE,SPF_HELO_FAIL,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following checkpatch errors are removed:
ERROR: "foo * bar" should be "foo *bar"
ERROR: "foo ** bar" should be "foo **bar"

Signed-off-by: Jie Shi <shijie001@208suo.com>
---
  scripts/kconfig/gconf.c | 82 ++++++++++++++++++++---------------------
  1 file changed, 41 insertions(+), 41 deletions(-)

diff --git a/scripts/kconfig/gconf.c b/scripts/kconfig/gconf.c
index 17adabfd6e6b..2d41058bec8c 100644
--- a/scripts/kconfig/gconf.c
+++ b/scripts/kconfig/gconf.c
@@ -66,8 +66,8 @@ enum {
  static void display_list(void);
  static void display_tree(struct menu *menu);
  static void display_tree_part(void);
-static void update_tree(struct menu *src, GtkTreeIter * dst);
-static void set_node(GtkTreeIter * node, struct menu *menu, gchar ** 
row);
+static void update_tree(struct menu *src, GtkTreeIter *dst);
+static void set_node(GtkTreeIter *node, struct menu *menu, gchar 
**row);
  static gchar **fill_row(struct menu *menu);
  static void conf_changed(void);

@@ -254,8 +254,8 @@ static void init_left_tree(void)
  }

  static void renderer_edited(GtkCellRendererText * cell,
-                const gchar * path_string,
-                const gchar * new_text, gpointer user_data);
+                const gchar *path_string,
+                const gchar *new_text, gpointer user_data);

  static void init_right_tree(void)
  {
@@ -407,8 +407,8 @@ static void text_insert_msg(const char *title, const 
char *message)

  /* Main Windows Callbacks */

-void on_save_activate(GtkMenuItem * menuitem, gpointer user_data);
-gboolean on_window1_delete_event(GtkWidget * widget, GdkEvent * event,
+void on_save_activate(GtkMenuItem *menuitem, gpointer user_data);
+gboolean on_window1_delete_event(GtkWidget *widget, GdkEvent *event,
                   gpointer user_data)
  {
      GtkWidget *dialog, *label;
@@ -453,15 +453,15 @@ gboolean on_window1_delete_event(GtkWidget * 
widget, GdkEvent * event,
  }

-void on_window1_destroy(GtkObject * object, gpointer user_data)
+void on_window1_destroy(GtkObject *object, gpointer user_data)
  {
      gtk_main_quit();
  }

  void
-on_window1_size_request(GtkWidget * widget,
-            GtkRequisition * requisition, gpointer user_data)
+on_window1_size_request(GtkWidget *widget,
+            GtkRequisition *requisition, gpointer user_data)
  {
      static gint old_h;
      gint w, h;
@@ -483,7 +483,7 @@ on_window1_size_request(GtkWidget * widget,

  static void
-load_filename(GtkFileSelection * file_selector, gpointer user_data)
+load_filename(GtkFileSelection *file_selector, gpointer user_data)
  {
      const gchar *fn;

@@ -496,7 +496,7 @@ load_filename(GtkFileSelection * file_selector, 
gpointer user_data)
          display_tree(&rootmenu);
  }

-void on_load1_activate(GtkMenuItem * menuitem, gpointer user_data)
+void on_load1_activate(GtkMenuItem *menuitem, gpointer user_data)
  {
      GtkWidget *fs;

@@ -516,7 +516,7 @@ void on_load1_activate(GtkMenuItem * menuitem, 
gpointer user_data)
  }

-void on_save_activate(GtkMenuItem * menuitem, gpointer user_data)
+void on_save_activate(GtkMenuItem *menuitem, gpointer user_data)
  {
      if (conf_write(NULL))
          text_insert_msg("Error", "Unable to save configuration !");
@@ -525,7 +525,7 @@ void on_save_activate(GtkMenuItem * menuitem, 
gpointer user_data)

  static void
-store_filename(GtkFileSelection * file_selector, gpointer user_data)
+store_filename(GtkFileSelection *file_selector, gpointer user_data)
  {
      const gchar *fn;

@@ -538,7 +538,7 @@ store_filename(GtkFileSelection * file_selector, 
gpointer user_data)
      gtk_widget_destroy(GTK_WIDGET(user_data));
  }

-void on_save_as1_activate(GtkMenuItem * menuitem, gpointer user_data)
+void on_save_as1_activate(GtkMenuItem *menuitem, gpointer user_data)
  {
      GtkWidget *fs;

@@ -558,14 +558,14 @@ void on_save_as1_activate(GtkMenuItem * menuitem, 
gpointer user_data)
  }

-void on_quit1_activate(GtkMenuItem * menuitem, gpointer user_data)
+void on_quit1_activate(GtkMenuItem *menuitem, gpointer user_data)
  {
      if (!on_window1_delete_event(NULL, NULL, NULL))
          gtk_widget_destroy(GTK_WIDGET(main_wnd));
  }

-void on_show_name1_activate(GtkMenuItem * menuitem, gpointer user_data)
+void on_show_name1_activate(GtkMenuItem *menuitem, gpointer user_data)
  {
      GtkTreeViewColumn *col;

@@ -576,7 +576,7 @@ void on_show_name1_activate(GtkMenuItem * menuitem, 
gpointer user_data)
  }

-void on_show_range1_activate(GtkMenuItem * menuitem, gpointer 
user_data)
+void on_show_range1_activate(GtkMenuItem *menuitem, gpointer user_data)
  {
      GtkTreeViewColumn *col;

@@ -594,7 +594,7 @@ void on_show_range1_activate(GtkMenuItem * menuitem, 
gpointer user_data)
  }

-void on_show_data1_activate(GtkMenuItem * menuitem, gpointer user_data)
+void on_show_data1_activate(GtkMenuItem *menuitem, gpointer user_data)
  {
      GtkTreeViewColumn *col;

@@ -632,7 +632,7 @@ on_set_option_mode3_activate(GtkMenuItem *menuitem, 
gpointer user_data)
  }

-void on_introduction1_activate(GtkMenuItem * menuitem, gpointer 
user_data)
+void on_introduction1_activate(GtkMenuItem *menuitem, gpointer 
user_data)
  {
      GtkWidget *dialog;
      const gchar *intro_text =
@@ -663,7 +663,7 @@ void on_introduction1_activate(GtkMenuItem * 
menuitem, gpointer user_data)
  }

-void on_about1_activate(GtkMenuItem * menuitem, gpointer user_data)
+void on_about1_activate(GtkMenuItem *menuitem, gpointer user_data)
  {
      GtkWidget *dialog;
      const gchar *about_text =
@@ -681,7 +681,7 @@ void on_about1_activate(GtkMenuItem * menuitem, 
gpointer user_data)
  }

-void on_license1_activate(GtkMenuItem * menuitem, gpointer user_data)
+void on_license1_activate(GtkMenuItem *menuitem, gpointer user_data)
  {
      GtkWidget *dialog;
      const gchar *license_text =
@@ -700,7 +700,7 @@ void on_license1_activate(GtkMenuItem * menuitem, 
gpointer user_data)
  }

-void on_back_clicked(GtkButton * button, gpointer user_data)
+void on_back_clicked(GtkButton *button, gpointer user_data)
  {
      enum prop_type ptype;

@@ -715,13 +715,13 @@ void on_back_clicked(GtkButton * button, gpointer 
user_data)
  }

-void on_load_clicked(GtkButton * button, gpointer user_data)
+void on_load_clicked(GtkButton *button, gpointer user_data)
  {
      on_load1_activate(NULL, user_data);
  }

-void on_single_clicked(GtkButton * button, gpointer user_data)
+void on_single_clicked(GtkButton *button, gpointer user_data)
  {
      view_mode = SINGLE_VIEW;
      gtk_widget_hide(tree1_w);
@@ -730,7 +730,7 @@ void on_single_clicked(GtkButton * button, gpointer 
user_data)
  }

-void on_split_clicked(GtkButton * button, gpointer user_data)
+void on_split_clicked(GtkButton *button, gpointer user_data)
  {
      gint w, h;
      view_mode = SPLIT_VIEW;
@@ -746,7 +746,7 @@ void on_split_clicked(GtkButton * button, gpointer 
user_data)
  }

-void on_full_clicked(GtkButton * button, gpointer user_data)
+void on_full_clicked(GtkButton *button, gpointer user_data)
  {
      view_mode = FULL_VIEW;
      gtk_widget_hide(tree1_w);
@@ -757,13 +757,13 @@ void on_full_clicked(GtkButton * button, gpointer 
user_data)
  }

-void on_collapse_clicked(GtkButton * button, gpointer user_data)
+void on_collapse_clicked(GtkButton *button, gpointer user_data)
  {
      gtk_tree_view_collapse_all(GTK_TREE_VIEW(tree2_w));
  }

-void on_expand_clicked(GtkButton * button, gpointer user_data)
+void on_expand_clicked(GtkButton *button, gpointer user_data)
  {
      gtk_tree_view_expand_all(GTK_TREE_VIEW(tree2_w));
  }
@@ -772,9 +772,9 @@ void on_expand_clicked(GtkButton * button, gpointer 
user_data)
  /* CTree Callbacks */

  /* Change hex/int/string value in the cell */
-static void renderer_edited(GtkCellRendererText * cell,
-                const gchar * path_string,
-                const gchar * new_text, gpointer user_data)
+static void renderer_edited(GtkCellRendererText *cell,
+                const gchar *path_string,
+                const gchar *new_text, gpointer user_data)
  {
      GtkTreePath *path = gtk_tree_path_new_from_string(path_string);
      GtkTreeIter iter;
@@ -855,7 +855,7 @@ static void toggle_sym_value(struct menu *menu)
          display_tree_part();    //fixme: keep exp/coll
  }

-static gint column2index(GtkTreeViewColumn * column)
+static gint column2index(GtkTreeViewColumn *column)
  {
      gint i;

@@ -873,8 +873,8 @@ static gint column2index(GtkTreeViewColumn * column)

  /* User click: update choice (full) or goes down (single) */
  gboolean
-on_treeview2_button_press_event(GtkWidget * widget,
-                GdkEventButton * event, gpointer user_data)
+on_treeview2_button_press_event(GtkWidget *widget,
+                GdkEventButton *event, gpointer user_data)
  {
      GtkTreeView *view = GTK_TREE_VIEW(widget);
      GtkTreePath *path;
@@ -930,8 +930,8 @@ on_treeview2_button_press_event(GtkWidget * widget,

  /* Key pressed: update choice */
  gboolean
-on_treeview2_key_press_event(GtkWidget * widget,
-                 GdkEventKey * event, gpointer user_data)
+on_treeview2_key_press_event(GtkWidget *widget,
+                 GdkEventKey *event, gpointer user_data)
  {
      GtkTreeView *view = GTK_TREE_VIEW(widget);
      GtkTreePath *path;
@@ -975,7 +975,7 @@ on_treeview2_key_press_event(GtkWidget * widget,

  /* Row selection changed: update help */
  void
-on_treeview2_cursor_changed(GtkTreeView * treeview, gpointer user_data)
+on_treeview2_cursor_changed(GtkTreeView *treeview, gpointer user_data)
  {
      GtkTreeSelection *selection;
      GtkTreeIter iter;
@@ -991,8 +991,8 @@ on_treeview2_cursor_changed(GtkTreeView * treeview, 
gpointer user_data)

  /* User click: display sub-tree in the right frame. */
  gboolean
-on_treeview1_button_press_event(GtkWidget * widget,
-                GdkEventButton * event, gpointer user_data)
+on_treeview1_button_press_event(GtkWidget *widget,
+                GdkEventButton *event, gpointer user_data)
  {
      GtkTreeView *view = GTK_TREE_VIEW(widget);
      GtkTreePath *path;
@@ -1159,7 +1159,7 @@ static gchar **fill_row(struct menu *menu)

  /* Set the node content with a row of strings */
-static void set_node(GtkTreeIter * node, struct menu *menu, gchar ** 
row)
+static void set_node(GtkTreeIter *node, struct menu *menu, gchar **row)
  {
      GdkColor color;
      gboolean success;
@@ -1245,7 +1245,7 @@ static GtkTreeIter 
*gtktree_iter_find_node(GtkTreeIter *parent,
   * Update the tree by adding/removing entries
   * Does not change other nodes
   */
-static void update_tree(struct menu *src, GtkTreeIter * dst)
+static void update_tree(struct menu *src, GtkTreeIter *dst)
  {
      struct menu *child1;
      GtkTreeIter iter, tmp;
